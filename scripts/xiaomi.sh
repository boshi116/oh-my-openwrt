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
project="xiaomi"
version="18.06.8"
device_profile="miwifi-nano"
imagebuilder_url="http://downloads.openwrt.org/releases/$version/targets/ramips/mt76x8/openwrt-imagebuilder-$version-ramips-mt76x8.Linux-x86_64.tar.xz"
sdk_url="https://downloads.openwrt.org/releases/$version/targets/ramips/mt76x8/openwrt-sdk-$version-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz"

# path
root_path=`pwd`
project_path="$root_path/$project"
sdk_path="$project_path/sdk"
ipk_path="$sdk_path/bin/packages/mipsel_24kc"
imagebuilder_path="$project_path/imagebuilder"
bin_path="$imagebuilder_path/bin/targets/ramips/mt76x8"

######################## setting env ########################
if [ ! -d $project ]; then
    mkdir -p $project
fi
cd $project_path
# image builder
if [ -d imagebuilder ]; then
    echo -e "$INFO imagebuilder already set done!"
else
    wget -O imagebuilder.tar.xz -t 5 -T 60 $imagebuilder_url
    echo "extract imagebuilder..."
    tar -xvf imagebuilder.tar.xz 1>/dev/null 2>&1
    mv openwrt-imagebuilder-$version-* imagebuilder
    rm -f imagebuilder.tar.xz
    echo -e "$INFO imagebuilder set done."
fi

# sdk
if [ -d sdk ]; then
    echo -e "$INFO sdk already set done!"
else
    wget -O sdk.tar.xz -t 5 -T 60 $sdk_url
    echo "extract sdk..."
    tar -xvf sdk.tar.xz 1>/dev/null 2>&1
    mv openwrt-sdk-$version-* sdk
    rm -rf sdk.tar.xz
    echo -e "$INFO sdk set done."
fi

# dir-link
## ln image builder
if [ ! -d $bin_path ]; then
    mkdir -p $bin_path
fi
if [ ! -L $project_path/image-bins ]; then
    ln -s $bin_path $project_path/image-bins
fi
## ln sdk
if [ ! -d $ipk_path/stuart ]; then
    mkdir -p $ipk_path/stuart
fi
if [ ! -L $project_path/sdk-ipks ]; then
    ln -s $ipk_path/stuart $project_path/sdk-ipks
fi
echo -e "$INFO dir-link set done!"

######################## download app code from stuart rep ########################
do_update_code(){
    echo "update code..."
    cd $root_path/oh-my-openwrt
    git pull origin master 1>/dev/null 2>&1
    echo -e "$INFO code update done!"
}
update_code(){
    while true; do
        echo -n -e "$INPUT"
        read -s -p "确认要更新 Stuart 软件包仓库代码吗 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* ) do_update_code; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}

if [ ! -d $root_path/oh-my-openwrt ]; then
    cd $root_path
    git clone https://github.com/stuarthua/oh-my-openwrt
    echo -e "$INFO code download done!"
else
    update_code
fi

######################## build ipks ########################
# install ipks build dependency
## for missing ncurses(libncurses.so or ncurses.h), 'unzip', Python 2.x, openssl
do_install_dep(){
    echo "install ipks build dependency begin..."
    sudo apt install libncurses5-dev unzip python libssl-dev -y
    echo -e "$INFO install ipks build dependency done!"
}
install_dep(){
    while true; do
        echo -n -e "$INPUT"
        read -s -p "确认要安装/更新软件包编译依赖吗 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* ) do_install_dep; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}
install_dep

# set config
if [ `grep -c "src-link stuart $root_path/oh-my-openwrt/stuart" $sdk_path/feeds.conf.default` -eq 0 ]; then
    echo "src-link stuart $root_path/oh-my-openwrt/stuart">>$sdk_path/feeds.conf.default
    echo -e "$INFO ipks-build config done!"
fi

# gen key
if [ ! -e $root_path/openwrt-stuart.key ]; then
    cd $sdk_path
    staging_dir/host/bin/usign -G -p $root_path/openwrt-stuart.pub -s $root_path/openwrt-stuart.key
    echo -e "$INFO openwrt-stuart.key gen done!"
fi

# feeds download
do_update_feeds(){
    echo "download feeds begin..."
    cd $sdk_path
    ./scripts/feeds update -a && ./scripts/feeds install -a
    # ./scripts/feeds update stuart && ./scripts/feeds install -a -p stuart
    echo -e "$INFO download feeds done!"
}
update_feeds(){
    while true; do
        echo -n -e "$INPUT"
        read -s -p "确认要安装/更新 feeds 吗 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* ) do_update_feeds; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}
update_feeds

# build ipks
do_build_ipks(){
    echo "build ipks begin..."
    
    cd $sdk_path
    
    # clean dir
    rm -rf $ipk_path/stuart
    mkdir -p $ipk_path/stuart
    
    # start build
    # make package/helloworld/compile V=s
    # make package/luci-app-stuart/compile V=s

    # 迅雷快鸟
    # make package/luci-app-xlnetacc/compile V=s
    # 定时唤醒
    # make package/luci-app-timewol/compile V=s
    # 上网时间控制
    # make package/luci-app-mia/compile V=s
    # 访问控制
    # make package/luci-app-webrestriction/compile V=s
    # 网址过滤
    # make package/luci-app-weburl/compile V=s

    # adbyby 去广告
    # make package/adbyby/compile V=s
    # make package/luci-app-adbyby-plus/compile V=s

    # lean 翻墙三合一
    # make package/shadowsocksr-libev/compile V=s
    # make package/kcptun/compile V=s
    # make package/v2ray/compile V=s
    # make package/pdnsd-alt/compile V=s
    # make package/luci-app-ssr-plus/compile V=s

    # USB 打印服务器
    # make package/luci-app-usb-printer/compile V=s

    # 释放内存
    make package/luci-app-ramfree/compile V=s
    # 文件助手
    make package/luci-app-fileassistant/compile V=s
    # IP/Mac 绑定
    make package/luci-app-arpbind/compile V=s
    # 定时重启
    make package/luci-app-autoreboot/compile V=s
    # KMS 自动激活（用于激活大客户版 Windows 及 Office）
    make package/vlmcsd/compile V=s
    make package/luci-app-vlmcsd/compile V=s
    # SQM 中文语言包
    make package/luci-i18n-sqm/compile V=s
    # 网页终端命令行
    make package/luci-app-ttyd/compile V=s

    echo -e "$INFO build ipks done!"
}

# @https://notes.iopush.net/how-to-setup-an-openwrt-repo/
do_index_ipks(){
    echo -e "$INFO gen ipks index begin..."

    export PATH="$sdk_path/staging_dir/host/bin:$PATH"

    # cd $ipk_path/packages
    # scripts/ipkg-make-index.sh . 2>/dev/null > Packages.manifest
    # grep -vE '^(Maintainer|LicenseFiles|Source|Require)' Packages.manifest > Packages
    # gzip -9nc Packages > Packages.gz
    # usign -S -m Packages -s $root_path/openwrt-stuart.key

    cd $ipk_path/stuart
    scripts/ipkg-make-index.sh . 2>/dev/null > Packages.manifest
    grep -vE '^(Maintainer|LicenseFiles|Source|Require)' Packages.manifest > Packages
    gzip -9nc Packages > Packages.gz
    usign -S -m Packages -s $root_path/openwrt-stuart.key
    echo -e "$INFO gen ipks index done!"
}

do_build_ipk_things(){
    # do_build_ipks
    do_index_ipks
}

build_ipks(){
    while true; do
        echo -n -e "$INPUT"
        read -s -p "确认要编译 Stuart 软件包吗 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* | "" ) do_build_ipk_things; break;;
            [Nn]* ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}

build_ipks

# build img

do_build_bin(){
    echo "build bin begin..."

    cd $imagebuilder_path

    # clean
    rm -rf $bin_path
    mkdir -p $bin_path
    rm -rf $imagebuilder_path/packages/stuart

    # add ipks from stuart
    cp -r $ipk_path/stuart $imagebuilder_path/packages

    # make
    org_original_pkgs="base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini"
    org_custom_pkgs="luci-i18n-base-zh-cn -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport luci-i18n-firewall-zh-cn luci-app-ddns luci-i18n-ddns-zh-cn luci-app-adblock luci-i18n-adblock-zh-cn luci-app-sqm libustream-openssl ca-bundle ca-certificates curl wget vsftpd openssh-sftp-server ipset iptables-mod-nat-extra -dnsmasq dnsmasq-full iptables-mod-tproxy ttyd"
    stuart_custom_pkgs="luci-app-ramfree luci-app-fileassistant luci-app-arpbind luci-i18n-arpbind-zh-cn luci-app-autoreboot luci-i18n-autoreboot-zh-cn vlmcsd luci-app-vlmcsd luci-i18n-vlmcsd-zh-cn luci-app-ttyd luci-i18n-ttyd-zh-cn shadowsocks-libev luci-app-shadowsocks ChinaDNS luci-app-chinadns dns-forwarder luci-app-dns-forwarder"
    image_pkgs="$org_original_pkgs $org_custom_pkgs $stuart_custom_pkgs"
    files_path="$root_path/oh-my-openwrt/FILES/$project/factory"

    make image PROFILE=$device_profile PACKAGES="${image_pkgs}" FILES=$files_path

    echo -e "$INFO build bin done!"
}

do_build_bin_things(){
    do_build_bin
}

build_bin(){
    while true; do
        echo -n -e "$INPUT"
        read -s -p "确认要编译固件吗 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* | "" ) do_build_bin_things; break;;
            [Nn]* ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}

build_bin