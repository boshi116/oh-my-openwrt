# 小米路由器青春版

在虚拟机上使用了一段时间 OpenWrt ，基本熟悉后，根据个人需求，确定好所需的软件包，开始着手定制个人使用的 OpenWrt 固件（在官方固件 `OpenWrt 18.06.4` 基础上）。

* 确定所需软件包
* 搭建环境
* 使用 SDK 编译所需的特定软件包（如 Shadowsocks）
* 使用 Image Builder 组装固件，生成个人定制版固件

## 准备

* 一台 Mac
* Ubuntu 14.04 LTS（运行在 VMware ）- 阅读：[在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](https://stuarthua.github.io/oh-my-openwrt/mybook/first-use/mac-vmware-install-ubuntu.html))
* 一台 小米路由器青春版

## 确定所需软件包

### 官方软件包

LuCI 及其依赖

* `luci-i18n-base-zh-cn` - LuCI 中文语言包
* `luci-app-firewall` - 防火墙
    * `luci-i18n-firewall-zh-cn` - 软件包 `luci-app-firewall` 的中文语言包
* `luci-app-ddns` - 动态 DDNS
    * `luci-i18n-ddns-zh-cn` - 软件包 `luci-app-ddns` 的中文语言包
    * `ddns-scripts` - 动态 DDNS 依赖的脚本
* `luci-app-adblock` - Adblock，著名的去广告软件
    * `luci-i18n-adblock-zh-cn` - 软件包 `luci-app-adblock` 的中文语言包
    * `adblock` - Adblock
* `luci-app-sqm` - 智能队列管理 SQM Qos，智能解决网络延迟和阻塞
    * `sqm-scripts` - SQM 依赖的脚本
* `curl` - 下载工具
* `wget` - 下载工具
* `vsftpd` - for sftp
* `openssh-sftp-server` - for sftp

### 第三方软件包

LuCI 及其依赖

* `luci-app-ramfree` - 释放内存
* `luci-app-fileassistant` - 文件助手，支持上传文件、安装 IPK 软件包
* `luci-app-arpbind` - IP/Mac 绑定
    * `luci-i18n-arpbind-zh-cn` - 软件包 `luci-app-arpbind` 的中文语言包
* `luci-app-autoreboot` - 定时重启
    * `luci-i18n-autoreboot-zh-cn` - 软件包 `luci-app-autoreboot` 的中文语言包
* `luci-app-vlmcsd` - KMS 服务器，用于激活 Windows 及 Office
    * `vlmcsd` - KMS Server
* `luci-app-shadowsocks` - LuCI for Shadowsocks
    * `shadowsocks-libev` - shadowsocks-libev
* `luci-app-chinadns` - LuCI for ChinaDNS
    * `ChinaDNS` - ChinaDNS
* `luci-app-dns-forwarder` - LuCI for DNS Forwarder
    * `dns-forwarder` - DNS Forwarder
* ~~`luci-i18n-sqm` - 软件包 `luci-app-sqm` 的中文语言包~~

## 搭建环境

Ubuntu 14.04 LTS (运行在虚拟机 VMware 上， IP: 192.168.128.140， 终端可翻墙)

在 Mac 上 SSH 连接 Ubuntu 虚拟机

```bash
ssh stuart@192.168.128.140
```

新建脚本 `set-xiaomi.sh`

```bash
touch set-xiaomi.sh
```

编辑脚本 `set-xiaomi.sh`

```bash
#!/usr/bin/env bash
cd ~

# image builder
wget http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz
tar -xvf openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz
mv openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64 openwrt-imagebuilder-xiaomi
rm -rf openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz

# sdk
wget https://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz
tar -xvf openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz
mv openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64 openwrt-sdk-xiaomi
rm -rf openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz

# ln image builder
mkdir -p /home/stuart/openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8
mkdir -p /home/stuart/image-bins
rm /home/stuart/image-bins/xiaomi
ln -s /home/stuart/openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8 /home/stuart/image-bins/xiaomi
# ln sdk
mkdir -p /home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/stuart
mkdir -p /home/stuart/sdk-ipks
rm /home/stuart/sdk-ipks/xiaomi
ln -s /home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/stuart /home/stuart/sdk-ipks/xiaomi
```

终端开启翻墙 - `startss`, 执行脚本 `set-xiaomi.sh`, 进行环境部署

```bash
startss
bash set-xiaomi.sh
```

至此，在 `/home/stuart` 用户目录下，存在 `image-bins` 和 `sdk-ipks` 两个目录，用来存放编译后的固件和 `.ipk` 软件包文件

## 使用 SDK 编译所需的特定软件包

### 添加个人软件包源码

终端开启翻墙 - `startss`，下载源码

```bash
cd ~ && git clone https://github.com/stuarthua/oh-my-openwrt
```

编辑 `~/openwrt-sdk-xiaomi/feeds.conf.default` 文件，添加个人源码路径

```
vi ~/openwrt-sdk-xiaomi/feeds.conf.default

# 添加
src-link stuart /home/stuart/oh-my-openwrt/stuart
```

### feeds 更新和安装

更新 SDK 中的 feeds 并安装

```bash
cd ~/openwrt-sdk-xiaomi && ./scripts/feeds update -a && ./scripts/feeds install -a
```

### 编译

新建脚本 `make-ipks.sh`

```bash
#!/usr/bin/env bash

# update
cd ~/oh-my-openwrt && git pull origin master
cd ~/openwrt-sdk-xiaomi && ./scripts/feeds update stuart && ./scripts/feeds install -a -p stuart

# clean
rm -rf /home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/stuart
mkdir -p /home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/stuart

# make
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
# 网页终端命令行
# make package/luci-app-ttyd/compile V=s

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
```

执行编译脚本 `make-ipks.sh`

```bash
bash make-ipks.sh
```

在 `~/sdk-ipks/xiaomi` 目录查看生成的 `.ipk` 软件包文件

## 使用 Image Builder 组装固件

### 添加个性化配置文件

终端开启翻墙 - `startss`，下载个性户配置文件 (一些路由器设置，如默认地址、密码、语言、时区等)

```bash
cd ~ && git clone https://github.com/stuarthua/oh-my-openwrt oh-my-openwrt-devices && git checkout -b devices origin/devices
```

### 编译

新建脚本 `make-image.sh`

```bash
#!/usr/bin/env bash

# update
cd ~/oh-my-openwrt-devices && git pull origin devices
cd ~/openwrt-imagebuilder-xiaomi

# clean
rm -rf /home/stuart/openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8
mkdir -p /home/stuart/openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8
rm -rf ~/openwrt-imagebuilder-xiaomi/packages/stuart

# add ipks from stuart
cp -r ~/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/stuart ~/openwrt-imagebuilder-xiaomi/packages
# add ipks from shadowsocks (@aa65535)
cp -r ~/oh-my-openwrt-devices/packages/all/*.ipk ~/openwrt-imagebuilder-xiaomi/packages/stuart
cp -r ~/oh-my-openwrt-devices/packages/xiaomi/*.ipk ~/openwrt-imagebuilder-xiaomi/packages/stuart

# make
ORG_ORIGIN_PKGS="base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini"
CUSTOM_ORG_PKGS="luci-i18n-base-zh-cn -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport luci-i18n-firewall-zh-cn luci-app-ddns luci-i18n-ddns-zh-cn luci-app-adblock luci-i18n-adblock-zh-cn luci-app-sqm curl wget vsftpd openssh-sftp-server"
CUSTOM_PKGS="luci-app-ramfree luci-app-fileassistant luci-app-arpbind luci-i18n-arpbind-zh-cn luci-app-autoreboot luci-i18n-autoreboot-zh-cn vlmcsd luci-app-vlmcsd luci-i18n-vlmcsd-zh-cn shadowsocks-libev luci-app-shadowsocks ChinaDNS luci-app-chinadns dns-forwarder luci-app-dns-forwarder"
IMAGE_PKGS="$ORG_ORIGIN_PKGS $CUSTOM_ORG_PKGS $CUSTOM_PKGS"

make image PROFILE=miwifi-nano PACKAGES="$IMAGE_PKGS" FILES=~/oh-my-openwrt-devices/devices/xiaomi

echo "编译结束"
```

执行编译脚本 `make-image.sh`

```bash
bash make-image.sh
```

在 `~/image-bins/xiaomi` 目录查看生成的固件

### 提示

OpenWrt 18.06.4 `小米路由器 NANO` 官方固件中默认安装的包有

```bash
$ echo `opkg list_installed | awk '{ print $1 }'`

base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc kmod-usb-core kmod-usb-ehci kmod-usb-ledtrig-usbport kmod-usb-ohci kmod-usb2 libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini
```

小米路由器青春版于 NANO 配置一样，只是去掉了 USB，故而可以省却 USB 相关的包

```
-kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport
```

## 安装固件


