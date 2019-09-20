# 编译时一些个人使用的脚本

## x86

OpenWrt 18.06.4

### 环境部署（Image Builder, SDK）

终端开启翻墙 - `startss`

```bash
#!/usr/bin/env bash
cd ~

# image builder
wget https://downloads.openwrt.org/releases/18.06.4/targets/x86/64/openwrt-imagebuilder-18.06.4-x86-64.Linux-x86_64.tar.xz
tar -xvf openwrt-imagebuilder-18.06.4-x86-64.Linux-x86_64.tar.xz
mv openwrt-imagebuilder-18.06.4-x86-64.Linux-x86_64 openwrt-imagebuilder-x86
rm -rf openwrt-imagebuilder-18.06.4-x86-64.Linux-x86_64.tar.xz

# sdk
wget https://downloads.openwrt.org/releases/18.06.4/targets/x86/64/openwrt-sdk-18.06.4-x86-64_gcc-7.3.0_musl.Linux-x86_64.tar.xz
tar -xvf openwrt-sdk-18.06.4-x86-64_gcc-7.3.0_musl.Linux-x86_64.tar.xz
mv openwrt-sdk-18.06.4-x86-64_gcc-7.3.0_musl.Linux-x86_64 openwrt-sdk-x86
rm -rf openwrt-sdk-18.06.4-x86-64_gcc-7.3.0_musl.Linux-x86_64.tar.xz

# ln image builder
mkdir -p /home/stuart/openwrt-imagebuilder-x86/bin/targets/x86/64
mkdir -p /home/stuart/image-bins
ln -s /home/stuart/openwrt-imagebuilder-x86/bin/targets/x86/64 /home/stuart/image-bins/x86
# ln sdk
mkdir -p /home/stuart/openwrt-sdk-x86/bin/packages/x86_64/stuart
mkdir -p /home/stuart/sdk-ipks
ln -s /home/stuart/openwrt-sdk-x86/bin/packages/x86_64/stuart /home/stuart/sdk-ipks/x86
```

### SDK

终端开启翻墙 - `startss`

* 准备

```bash
cd ~ && git clone https://github.com/stuarthua/oh-my-openwrt
```

更新

```bash
cd ~/oh-my-openwrt && git pull
```

编辑 `~/openwrt-sdk-x86/feeds.conf.default`

```
vi ~/openwrt-sdk-x86/feeds.conf.default

# 添加
src-link stuart /home/stuart/oh-my-openwrt/stuart
```

* feeds 更新并安装

```bash
cd ~/openwrt-sdk-x86 && ./scripts/feeds update -a && ./scripts/feeds install -a
```

* 编译软件包

进入 `~/openwrt-sdk-x86`

```bash
cd ~/openwrt-sdk-x86
```

以 helloworld 为例，执行编译

```bash
make package/helloworld/compile V=s
```

在 `~/sdk-ipks/x86` 目录查看生成的软件包

### 脚本化

* 更新

新建脚本 `update_by_stuart.sh`

```bash
cd ~/openwrt-sdk-x86
touch update_by_stuart.sh
```

编辑 `update_by_stuart.sh`

```bash
#!/usr/bin/env bash
cd ~/oh-my-openwrt && git pull
cd ~/openwrt-sdk-x86 && ./scripts/feeds update stuart && ./scripts/feeds install -a -p stuart
```

* 编译

新建脚本 `make_by_stuart.sh`

```bash
cd ~/openwrt-sdk-x86
touch make_by_stuart.sh
```

编辑 `make_by_stuart.sh`

```bash
#!/usr/bin/env bash
#make package/helloworld/compile V=s
#make package/luci-app-stuart/compile V=s
make package/luci-app-ramfree/compile V=s
make package/luci-app-fileassistant/compile V=s
make package/luci-app-arpbind/compile V=s
make package/luci-app-usb-printer/compile V=s
make package/luci-app-autoreboot/compile V=s
make package/vlmcsd/compile V=s
make package/luci-app-vlmcsd/compile V=s
make package/luci-app-xlnetacc/compile V=s
make package/luci-app-timewol/compile V=s
make package/luci-app-mia/compile V=s
make package/luci-app-webrestriction/compile V=s
make package/luci-app-weburl/compile V=s
make package/adbyby/compile V=s
make package/luci-app-adbyby-plus/compile V=s
make package/luci-app-ttyd/compile V=s
make package/chinadns/compile V=s
make package/dns-forwarder/compile V=s
make package/luci-app-puredns/compile V=s
make package/shadowsocks/compile V=s
make package/luci-app-shadowsocks/compile V=s
# make package/shadowsocksr-libev/compile V=s
# make package/kcptun/compile V=s
# make package/v2ray/compile V=s
# make package/pdnsd-alt/compile V=s
# make package/luci-app-ssr-plus/compile V=s
```

在 `~/sdk-ipks/x86` 目录查看生成的软件包，将其上传至路由器

* 安装第三方软件包

SSH 连接路由器

```bash
opkg install *.ipk
```

删除 LuCI 缓存，刷新浏览器界面，查看是否生效

```bash
rm -rf /tmp/luci-*
```

* 移除第三方旧软件包

SSH 连接路由器

```bash
## 移除第三方程序语言包
opkg remove luci-i18n-arpbind-zh-cn luci-i18n-autoreboot-zh-cn luci-i18n-usb-printer-zh-cn luci-i18n-vlmcsd-zh-cn luci-i18n-adbyby-plus-zh-cn luci-i18n-ttyd-zh-cn

## 移除第三方程序
opkg remove luci-app-ramfree luci-app-fileassistant luci-app-arpbind luci-app-usb-printer luci-app-autoreboot luci-app-vlmcsd vlmcsd luci-app-xlnetacc luci-app-timewol luci-app-mia luci-app-webrestriction luci-app-weburl luci-app-adbyby-plus adbyby luci-app-ttyd luci-app-shadowsocks shadowsocks luci-app-chinadns luci-app-dns-forwarder ChinaDNS dns-forwarder
```

### Image Builder

终端开启翻墙 - `startss`

* 准备

```bash
cd ~ && git clone https://github.com/stuarthua/oh-my-openwrt oh-my-openwrt-devices && git checkout -b devices origin/devices
```

更新

```bash
cd ~/oh-my-openwrt-devices && git pull
```

* 生成固件

进入 `~/openwrt-imagebuilder-x86`

```bash
cd ~/openwrt-imagebuilder-x86
```

执行编译

```bash
make image PROFILE=Generic \
PACKAGES="base-files busybox dnsmasq dropbear e2fsprogs firewall fstools fwtool ip6tables iptables jshn jsonfilter kernel kmod-button-hotplug kmod-e1000 kmod-e1000e kmod-hwmon-core kmod-i2c-algo-bit kmod-i2c-core kmod-igb kmod-input-core kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-lib-crc-ccitt kmod-mii kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-ppp kmod-pppoe kmod-pppox kmod-pps kmod-ptp kmod-r8169 kmod-slhc libblkid libblobmsg-json libc libcomerr libext2fs libf2fs libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread librt libsmartcols libss libubox libubus libubus-lua libuci libuclient libuuid libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mkf2fs mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg partx-utils ppp ppp-mod-pppoe procd r8169-firmware rpcd rpcd-mod-rrdns ubox ubus ubusd uci uclient-fetch uhttpd usign luci-i18n-base-zh-cn" \
FILES=~/oh-my-openwrt-devices/devices/x86
```

在 `~/image-bins/x86` 目录查看生成的固件

## 小米路由器青春版

OpenWrt 18.06.4

### 环境部署（Image Builder, SDK）

终端开启翻墙 - `startss`

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
ln -s /home/stuart/openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8 /home/stuart/image-bins/xiaomi
# ln sdk
mkdir -p /home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/base
mkdir -p /home/stuart/sdk-ipks
ln -s /home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/base /home/stuart/sdk-ipks/xiaomi
```

### Image Builder

终端开启翻墙 - `startss`

* 准备

```bash
cd ~ && git clone https://github.com/stuarthua/oh-my-openwrt oh-my-openwrt-devices && git checkout -b devices origin/devices
```

更新

```bash
cd ~/oh-my-openwrt-devices && git pull
```

* 生成固件

进入 `~/openwrt-imagebuilder-xiaomi`

```bash
cd ~/openwrt-imagebuilder-xiaomi
```

执行编译

```bash
make image PROFILE=miwifi-nano \
PACKAGES="base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini luci-i18n-base-zh-cn -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport" \
FILES=~/oh-my-openwrt-devices/devices/xiaomi
```

在 `~/image-bins/xiaomi` 目录查看生成的固件

### SDK

终端开启翻墙 - `startss`

* 准备

```bash
cd ~ && git clone https://github.com/stuarthua/oh-my-openwrt
```

更新

```bash
cd ~/oh-my-openwrt && git pull
```

编辑 `~/openwrt-sdk-xiaomi/feeds.conf.default`

```
vi ~/openwrt-sdk-xiaomi/feeds.conf.default

# 添加
src-link stuart /home/stuart/oh-my-openwrt/stuart
```

* feeds 更新并安装

```bash
cd ~/openwrt-sdk-xiaomi && ./scripts/feeds update -a && ./scripts/feeds install -a
```

* 编译软件包

进入 `~/openwrt-sdk-xiaomi`

```bash
cd ~/openwrt-sdk-xiaomi
```

以 helloworld 为例，执行编译

```bash
make package/helloworld/compile V=s
```

在 `~/sdk-ipks/xiaomi` 目录查看生成的软件包

## 附录

* 更新 stuart 软件源仓库及 devices

终端开启翻墙 - `startss`

```bash
cd ~/oh-my-openwrt && git pull && cd ~/oh-my-openwrt-devices && git pull
```

* feeds 更新及安装 (x86, xiaomi)

终端开启翻墙 - `startss`

```
cd ~/openwrt-sdk-xiaomi && ./scripts/feeds update -a && ./scripts/feeds install -a && cd ~/openwrt-sdk-x86 && ./scripts/feeds update -a && ./scripts/feeds install -a
```