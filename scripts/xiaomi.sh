#!/usr/bin/env bash

BOLD="\033[1m"
NORM="\033[0m"
INFO="$BOLD Info: $NORM"
INPUT="$BOLD => $NORM"
ERROR="\033[31m *** Error: $NORM"
WARNING="\033[33m * Warning: $NORM"

# if error occured, then exit
set -e

# common
version="18.06.8"
device="xiaomi"
device_profile="miwifi-nano"
cpu_arch="mipsel_24kc"
imagebuilder_url="http://downloads.openwrt.org/releases/$version/targets/ramips/mt76x8/openwrt-imagebuilder-$version-ramips-mt76x8.Linux-x86_64.tar.xz"
sdk_url="https://downloads.openwrt.org/releases/$version/targets/ramips/mt76x8/openwrt-sdk-$version-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz"
bin_ext=".bin"

# prepare
if [ ! -d build_openwrt ]; then
    mkdir -p build_openwrt
fi
cd build_openwrt

# path
root_path=`pwd`
device_path="$root_path/$device"
code_path="$root_path/stuart-openwrt"
sdk_path="$device_path/sdk"
ipk_path="$sdk_path/bin/packages/mipsel_24kc"
imagebuilder_path="$device_path/imagebuilder"
bin_path="$imagebuilder_path/bin/targets/ramips/mt76x8"
artifact_root_path="$root_path/artifacts/$version"
artifact_bin_path="$artifact_root_path/targets/$device"
artifact_ipk_path="$artifact_root_path/packages"

# prepare
if [ ! -d $device ]; then
    mkdir -p $device
fi
cd $device_path

######################## set env ########################
# image builder
pre_imagebuilder(){
    if [ -d imagebuilder ]; then
        echo -e "$INFO imagebuilder already set done!"
    else
        echo "download imagebuilder..."
        wget -O imagebuilder.tar.xz -t 5 -T 60 $imagebuilder_url
        echo "download imagebuilder done."
        echo "extract imagebuilder..."
        tar -xvf imagebuilder.tar.xz 1>/dev/null 2>&1
        mv openwrt-imagebuilder-$version-* imagebuilder
        rm -f imagebuilder.tar.xz
        echo -e "$INFO imagebuilder set done."
    fi
}
pre_imagebuilder

# sdk
pre_sdk(){
    if [ -d sdk ]; then
        echo -e "$INFO sdk already set done!"
    else
        echo "download sdk..."
        wget -O sdk.tar.xz -t 5 -T 60 $sdk_url
        echo "download sdk done."
        echo "extract sdk..."
        tar -xvf sdk.tar.xz 1>/dev/null 2>&1
        mv openwrt-sdk-$version-* sdk
        rm -rf sdk.tar.xz
        echo -e "$INFO sdk set done."
    fi
}
pre_sdk

# artifact dir
pre_artifacts_dir(){
    ## dir bins
    if [ ! -d $bin_path ]; then
        mkdir -p $bin_path
    fi
    if [ ! -L $device_path/bins ]; then
        ln -s $bin_path $device_path/bins
    fi
    if [ ! -d $artifact_bin_path ]; then
        mkdir -p $artifact_bin_path
    fi
    ## dir ipks
    if [ ! -d $ipk_path/stuart ]; then
        mkdir -p $ipk_path/stuart
    fi
    if [ ! -L $device_path/ipks ]; then
        ln -s $ipk_path $device_path/ipks
    fi
    if [ ! -d $artifact_ipk_path ]; then
        mkdir -p $artifact_ipk_path
        mkdir -p $artifact_ipk_path/luci
        mkdir -p $artifact_ipk_path/base/$device
    fi
    echo -e "$INFO artifact dir set done!"
}
pre_artifacts_dir

######################## clone or update code from stuart rep ########################
do_update_code(){
    echo "update code..."
    cd $code_path
    git pull
    git checkout master 1>/dev/null 2>&1
    rm -rf devices_config
    cp -r devices devices_config
    git checkout develop 1>/dev/null 2>&1
    git pull
    echo -e "$INFO code update done!"
}
dp_clone_code(){
    echo "clone code..."
    cd $root_path
    rm -rf $code_path
    git clone https://github.com/stuarthua/oh-my-openwrt stuart-openwrt
    cd stuart-openwrt
    cp -r devices devices_config
    git checkout -b develop origin/develop
    echo -e "$INFO code clone done!"
}
clone_or_update_code(){
    if [ ! -d $code_path ]; then
        mkdir -p $code_path
    fi
    result=`ls $code_path`
    if [ -z "$result" ]; then
        dp_clone_code
    else
        do_update_code
    fi
}
clone_or_update_code

######################## build config ########################
build_config(){
    # import stuart code to sdk
    if [ `grep -c "src-link stuart $code_path/stuart" $sdk_path/feeds.conf.default` -eq 0 ]; then
        echo "ipks-build config..."
        echo "src-link stuart $code_path/stuart">>$sdk_path/feeds.conf.default
        echo -e "$INFO ipks-build config done!"
    fi
}
build_config

######################## feeds update and install ########################
# feeds download
do_update_feeds(){
    echo "download feeds begin..."
    cd $sdk_path
    ./scripts/feeds update -a && ./scripts/feeds install -a
    # ./scripts/feeds update stuart && ./scripts/feeds install -a -p stuart
    echo -e "$INFO download feeds done!"
}
update_feeds(){
    cd $sdk_path
    if [ -d staging_dir/host/bin  ]; then
        result=`ls staging_dir/host/bin`
        if [ -z "$result" ]; then
            do_update_feeds
            return
        fi
    else
        do_update_feeds
        return
    fi
    while true; do
        echo -n -e "$INPUT"
        read -p "是否 安装/更新 feeds (y/n) ? " yn
        echo
        case $yn in
            [Yy]* ) do_update_feeds; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}
update_feeds

######################## build config ########################
default_config(){
    cd $sdk_path
    if [ ! -e .config ]; then
        if [ -d $code_path/devices_config ]; then
            cp -f $code_path/devices_config/$device/sdk.config .config
        fi
    fi
}
choose_config(){
    cd $sdk_path
    while true; do
        echo -n -e "$INPUT"
        read -p "是否需要修改编译配置 (y/n) ? " yn
        echo
        case $yn in
            [Yy]* ) make menuconfig; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}
default_config
choose_config

######################## build ########################

# build ipks
archive_ipks(){
    cd $ipk_path/stuart
    cp -f luci-*_all.ipk $artifact_ipk_path/luci
    cp -f *_$cpu_arch.ipk $artifact_ipk_path/base/$device
}
do_build_ipks(){
    echo "build ipks begin..."

    cd $sdk_path

    # clean dir
    rm -rf $ipk_path/stuart
    mkdir -p $ipk_path/stuart

    ################# start build for detail ######################

    make package/adbyby/compile V=s                                  # adbyby 去广告
    make package/ddns-scripts_aliyun/compile V=s                     # aliyun ddns
    make package/ipt2socks/compile V=s                               # ipt2socks
    make package/luci-app-adbyby-plus/compile V=s                    # luci adbyby 去广告
    make package/luci-app-arpbind/compile V=s                        # luci 静态 ARP 绑定
    make package/luci-app-autoreboot/compile V=s                     # luci 定时重启
    make package/luci-app-fileassistant/compile V=s                  # luci 文件助手
    make package/luci-app-flowoffload/compile V=s                    # luci Turbo ACC 网络加速
    make package/luci-app-ipsec-vpnd/compile V=s                     # luci IPSec VPN
    make package/luci-app-mia/compile V=s                            # luci 上网时间控制
    make package/luci-app-ramfree/compile V=s                        # luci 释放内存
    make package/luci-app-ssr-plus/compile V=s                       # luci ssr plus
    make package/luci-app-stuart/compile V=s                         # luci Example，无用
    make package/luci-app-timewol/compile V=s                        # luci 定时唤醒
    make package/luci-app-ttyd/compile V=s                           # luci 网页终端
    # make package/luci-app-usb-printer/compile V=s                    # luci USB 打印服务器
    make package/luci-app-vlmcsd/compile V=s                         # luci KMS 服务器
    make package/luci-app-webadmin/compile V=s                       # luci Web 管理
    make package/luci-app-webrestriction/compile V=s                 # luci 访问控制
    make package/luci-app-weburl/compile V=s                         # luci 网址过滤
    make package/luci-app-xlnetacc/compile V=s                       # luci 迅雷快鸟
    make package/luci-i18n-adbyby-plus-zh-cn/compile V=s             # 语言包
    make package/luci-i18n-arpbind-zh-cn/compile V=s                 # 语言包
    make package/luci-i18n-autoreboot-zh-cn/compile V=s              # 语言包
    make package/luci-i18n-flowoffload-zh-cn/compile V=s             # 语言包
    make package/luci-i18n-ipsec-vpnd-zh-cn/compile V=s              # 语言包
    make package/luci-i18n-sqm/compile V=s                           # 语言包
    make package/luci-i18n-ttyd-zh-cn/compile V=s                    # 语言包
    make package/luci-i18n-usb-printer-zh-cn/compile V=s             # 语言包
    make package/luci-i18n-vlmcsd-zh-cn/compile V=s                  # 语言包
    make package/luci-i18n-webadmin-zh-cn/compile V=s                # 语言包
    make package/microsocks/compile V=s                              # ssr plus 的依赖
    make package/pdnsd-alt/compile V=s                               # ssr plus 的依赖
    make package/shadowsocksr-libev/compile V=s                      # ssr plus 的依赖
    make package/shadowsocksr-libev-alt/compile V=s                  # ssr plus 的依赖
    make package/shadowsocksr-libev-server/compile V=s               # ssr plus 的依赖
    make package/shadowsocksr-libev-ssr-local/compile V=s            # ssr plus 的依赖
    make package/simple-obfs/compile V=s                             # ssr plus 的依赖
    make package/simple-obfs-server/compile V=s                      # ssr plus 的依赖
    make package/trojan/compile V=s                                  # ssr plus 的依赖
    make package/v2ray/compile V=s                                   # ssr plus 的依赖
    make package/v2ray-plugin/compile V=s                            # ssr plus 的依赖
    make package/vlmcsd/compile V=s                                  # KMS 服务器

    ################# end build for detail ######################

    echo -e "$INFO build ipks done!"

    # 归档 ipks
    archive_ipks
}

build_ipks(){
    while true; do
        echo -n -e "$INPUT"
        read -p "是否编译 Stuart 软件包 (y/n) ? " yn
        echo
        case $yn in
            [Yy]* ) do_build_ipks; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}

build_ipks

# build img
archive_bin(){
    cd $bin_path
    cp -f openwrt-${version}*${bin_ext} $artifact_bin_path/stuart-openwrt-$version-$device-$build_type${bin_ext}
    cat > $artifact_bin_path/README.md << "EOF"
## README

说明:

* `ext4` 结尾的固件指 rootfs 工作区存储格式为 ext4
* `squashfs` 结尾的固件类似 win 的 ghost 版本，使用中如发生配置错误，可恢复出厂默认设置
    * `squashfs-factory` 结尾的固件指出厂固件
    * `squashfs-sysupgrade` 结尾的固件指升级固件
* `jffs2` 结尾的固件可以自行修改 rootfs 的配置文件，不需要重新刷固件
* `initramfs-kernel` 结尾的固件一般用于没有 flash 闪存驱动的设备，系统运行于内存中，重启后所有设置都将丢失，不常用

固件:

* OpenWrt 官方固件
* Stuart-Openwrt 出厂固件(中文化、本地设置等)
* Stuart-Openwrt 升级固件(出厂固件基础上增加更多功能性软件包)

EOF
}
do_build_bin(){
    echo "build $build_type bin begin..."

    cd $imagebuilder_path

    # clean
    rm -rf $bin_path
    mkdir -p $bin_path
    rm -rf $imagebuilder_path/packages/stuart

    # add ipks from stuart
    cp -r $ipk_path/stuart $imagebuilder_path/packages

    # make
    org_original_pkgs="base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini"
    org_custom_pkgs="luci-i18n-base-zh-cn -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport luci-i18n-firewall-zh-cn libustream-openssl ca-bundle ca-certificates curl wget vsftpd openssh-sftp-server -dnsmasq dnsmasq-full ttyd"
    ## factory
    stuart_factory_pkgs="luci-app-ramfree luci-app-fileassistant luci-app-arpbind luci-i18n-arpbind-zh-cn luci-app-autoreboot luci-i18n-autoreboot-zh-cn vlmcsd luci-app-vlmcsd luci-i18n-vlmcsd-zh-cn luci-app-ttyd luci-i18n-ttyd-zh-cn"
    ## sysupgrade
    stuart_sysupgrade_pkgs="$stuart_factory_pkgs shadowsocks-libev luci-app-shadowsocks ChinaDNS luci-app-chinadns dns-forwarder luci-app-dns-forwarder"

    if [ $build_type == "factory" ]; then
        image_pkgs="$org_original_pkgs $org_custom_pkgs $stuart_factory_pkgs"
        files_path="$code_path/devices_config/$device/factory"
    else
        image_pkgs="$org_original_pkgs $org_custom_pkgs $stuart_sysupgrade_pkgs"
        files_path="$code_path/devices_config/$device/sysupgrade"
    fi

    make image PROFILE=$device_profile PACKAGES="${image_pkgs}" FILES=$files_path

    echo -e "$INFO build $build_type bin done!"

    archive_bin
}

choose_build_type(){
    while true; do
        echo -n -e "$INPUT"
        read -p "请选择固件类型 ( 0/1/2 | 0 取消, 1 出厂固件, 2 升级固件 ) : " yn
        echo
        case $yn in
            1 ) build_type="factory"; do_build_bin; break;;
            2 ) build_type="sysupgrade"; do_build_bin; break;;
            0  | "") echo -e "$INFO 取消编译"; break;;
            * ) echo "输入 1(出厂固件), 2(升级固件) 或 0(取消) 以确认";;
        esac
    done
}

build_bin(){
    while true; do
        echo -n -e "$INPUT"
        read -p "是否编译 Stuart 固件 (y/n) ? " yn
        echo
        case $yn in
            [Yy]* ) choose_build_type; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}

result=`ls $ipk_path/stuart`
if [ -n "$result" ]; then
    build_type="factory"
    build_bin
fi

echo -e "$INFO End!"