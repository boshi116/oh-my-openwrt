# 使用 Image Builder 组装固件镜像

Image Builder 是 Openwrt 官方提供的用来快捷生成所需固件的工具包，这个工具包已经包含并配置好了所有编译需要的程序，一条命令即可生成所需的固件，并且可以通过修改 `Makefile` 和一些配置文件来生成自定义的固件，是相对简洁易用的方式。

如果你的设备同样存在闪存小，无法使用 opkg 安装软件的问题，可以尝试使用 Image Builder 定制自己的固件，将需要的软件定制编译到固件中，以固件升级的方式安装特定软件。

以 小米路由器青春版 为例

* 闪存 - 16M
* 内存 - 64M

## 准备

* 阅读：[在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](https://stuarthua.github.io/oh-my-openwrt/mybook/first-use/mac-vmware-install-ubuntu.html)
* 阅读：[小米路由器青春版使用官方 OpenWrt](https://stuarthua.github.io/oh-my-openwrt/mybook/first-use/use-official-openwrt-on-xiaomi-nano.html)
* 硬件：小米路由器青春版

## 下载 Image Builder

下载适合自己无线路由器的 Image Builder, 从 [http://downloads.openwrt.org/](http://downloads.openwrt.org/) 选择适合自己的目录

小米路由器青春版硬件与小米路由器 mini 基本一致，只是缺少 usb 模块，编译时，取消 usb 相关 package 即可。

* 架构：ramips
* 芯片型号：mt76x8
* 版本：Release 18.06.4
* OpenWrt Xiaomi Nano：[https://openwrt.org/toh/xiaomi/nano](https://openwrt.org/toh/xiaomi/nano)
* mt76x8 Image Builder 下载地址：[openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz](http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz)

Mac 上使用 SSH 连接 Ubuntu (IP: 192.168.128.140)

```bash
$ ssh stuart@192.168.128.140
```

下载并解压 Image Builder 包

```bash
$ wget http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz
$ tar -xvf openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz
```

得到 `openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64` 目录，重命名为 `openwrt-imagebuilder-xiaomi`

```bash
$ mv openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64 openwrt-imagebuilder-xiaomi
$ rm -rf openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz
```

`openwrt-imagebuilder-xiaomi` 目录包含并配置好了所有适用于编译小米路由器青春版固件需要的程序

## 使用 Image Builder

[官方 Image Builder 使用指引](https://openwrt.org/start?id=zh/docs/guide-user/additional-software/imagebuilder)

Image Builder 编译命令示例：

```bash
make image PROFILE=XXX PACKAGES="pkg1 pk2 -pkg3 -pkg4" FILES=files/
```

共有三个要传递的参数：PROFILE PACKAGES FILES:

* PROFILE 指定设备类型，即预定义的 Profile，对应路由器型号
* PACKAGES 指定需要编译进固件中的包，不填写的话只包含预定义需要的最少的包，如果前面以 `-` 符号开头的表示不不含这个包
* FILES 指定要编译进固件的自定义文件，如网络有关配置文件、自定义包。

其他参数 (非必要参数，了解即可)：

* BIN_DIR - 自定义固件输出目录
* EXTRA_IMAGE_NAME - 固件文件名拓展
* DISABLED_SERVICES - 应禁用/etc/init.d/中的哪些服务。使用在/etc/init.d中找到的initscript名称，例如 dnsmasq 的“dhcp”

查看当前芯片固件的默认软件包和硬件支持列表

```bash
$ cd openwrt-imagebuilder-xiaomi
$ make info
```

显示如下：

<details>
<summary class="btn">点击展开详情</summary>
<pre class="highlight mt1">
<code>stuart@ubuntu:~/openwrt-imagebuilder-xiaomi$ make info
Current Target: "ramips (MT76x8 based boards)"
Default Packages: base-files libc libgcc busybox dropbear mtd uci opkg netifd fstools uclient-fetch logd kmod-leds-gpio kmod-gpio-button-hotplug swconfig kmod-mt76 wpad-mini dnsmasq iptables ip6tables ppp ppp-mod-pppoe firewall odhcpd-ipv6only odhcp6c kmod-ipt-offload
Available Profiles:

Default:
    Default Profile
    Packages: kmod-usb-core kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport iwinfo
alfa-network_awusfree1:
    ALFA Network AWUSFREE1
    Packages: uboot-envtools
wcr-1166ds:
    Buffalo WCR-1166DS
    Packages:
duzun-dm06:
    DuZun DM06
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
gl-mt300n-v2:
    GL-iNet GL-MT300N-V2
    Packages: kmod-usb2 kmod-usb-ohci
hc5661a:
    HiWiFi HC5661A
    Packages:
LinkIt7688:
    MediaTek LinkIt Smart 7688
    Packages: kmod-usb2 kmod-usb-ohci uboot-envtools
mt7628:
    MediaTek MT7628 EVB
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
mac1200r-v2:
    Mercury MAC1200R v2.0
    Packages:
omega2:
    Onion Omega2
    Packages: kmod-usb2 kmod-usb-ohci uboot-envtools
omega2p:
    Onion Omega2+
    Packages: kmod-usb2 kmod-usb-ohci uboot-envtools kmod-sdhci-mt7620
pbr-d1:
    PBR-D1
    Packages: kmod-usb2 kmod-usb-ohci
tplink_c20-v4:
    TP-Link ArcherC20 v4
    Packages:
tplink_c50-v3:
    TP-Link ArcherC50 v3
    Packages:
tplink_tl-mr3420-v5:
    TP-Link TL-MR3420 v5
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
tl-wr840n-v4:
    TP-Link TL-WR840N v4
    Packages:
tl-wr840n-v5:
    TP-Link TL-WR840N v5
    Packages:
tl-wr841n-v13:
    TP-Link TL-WR841N v13
    Packages:
tplink_tl-wr842n-v5:
    TP-Link TL-WR842N v5
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
tplink_tl-wr902ac-v3:
    TP-Link TL-WR902AC v3
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
tama_w06:
    Tama W06
    Packages: kmod-usb2 kmod-usb-ohci
u7628-01-128M-16M:
    UniElec U7628-01 (128M RAM/16M flash)
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
vocore2:
    VoCore VoCore2
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport kmod-sdhci-mt7620
vocore2lite:
    VoCore VoCore2-Lite
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport kmod-sdhci-mt7620
wrtnode2p:
    WRTnode 2P
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
wrtnode2r:
    WRTnode 2R
    Packages: kmod-usb2 kmod-usb-ohci
wl-wn575a3:
    Wavlink WL-WN575A3
    Packages:
widora_neo-16m:
    Widora-NEO (16M)
    Packages: kmod-usb2 kmod-usb-ohci
widora_neo-32m:
    Widora-NEO (32M)
    Packages: kmod-usb2 kmod-usb-ohci
miwifi-nano:
    Xiaomi MiWiFi Nano
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
zbtlink_zbt-we1226:
    ZBTlink ZBT-WE1226
    Packages:</code></pre>
</details>

提取有用信息，以小米路由器青春版为例

```
Default Packages: base-files libc libgcc busybox dropbear mtd uci opkg netifd fstools uclient-fetch logd kmod-leds-gpio kmod-gpio-button-hotplug swconfig kmod-mt76 wpad-mini dnsmasq iptables ip6tables ppp ppp-mod-pppoe firewall odhcpd-ipv6only odhcp6c kmod-ipt-offload
Available Profiles:
Default:
    Default Profile
    Packages: kmod-usb-core kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport iwinfo
miwifi-nano:
    Xiaomi MiWiFi Nano
    Packages: kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport
```

### 确定 小米路由器青春版 PROFILE

* Default Packages (默认安装的包): `base-files libc libgcc busybox dropbear mtd uci opkg netifd fstools uclient-fetch logd kmod-leds-gpio kmod-gpio-button-hotplug swconfig kmod-mt76 wpad-mini dnsmasq iptables ip6tables ppp ppp-mod-pppoe firewall odhcpd-ipv6only odhcp6c kmod-ipt-offload`
* Default Profile Packages (所有型号路由器共用包): `kmod-usb-core kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport iwinfo`
* Xiaomi MiWiFi Nano Profile: `miwifi-nano`
* Xiaomi MiWiFi Nano Packages (专属包): `kmod-usb2 kmod-usb-ohci kmod-usb-ledtrig-usbport`

现在，我们可以确定 `PROFILE=miwifi-nano`，但 PACKAGES 的确定需要一些考量

### 确定 小米路由器青春版 PACKAGES

首先，我们来获取官方固件中包含的软件包文件列表

SSH 连接安装官方固件的小米路由器青春版，恢复出厂设置并重启 (是的，为了这个配置，我们需要折腾设备了)

```bash
$ firstboot
$ reboot
```

路由器重启完成后，重新 SSH 连接路由器，查看一下官方固件默认安装的软件包

```bash
$ echo $(opkg list_installed | awk '{ print $1 }')

base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc kmod-usb-core kmod-usb-ehci kmod-usb-ledtrig-usbport kmod-usb-ohci kmod-usb2 libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini
```

可以看出，与 `make info` 得到的 Default Packages 相比，软件包多了不少，其中包含了 `luci luci-app-firewall` 等必要的软件包

> **提示：** 查询官方软件包信息的地址：[https://openwrt.org/packages/table/start](https://openwrt.org/packages/table/start) 可以对照包名查询其功能描述

小米路由器青春版没有 usb 模块，可以移除 usb 相关的包 `-kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport`

LuCI Web 一般会想要安装中文界面 `luci-i18n-base-zh-cn`

最终，我们可以确定 `PACKAGES`

```
PACKAGES="base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini luci-i18n-base-zh-cn -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport"
```

### 确定 小米路由器青春版 FILES

我们希望，刷机完成后，可以

* 默认开启无线
* 配置时区、NTP
* 添加自定义 ipk，如 luci-app-helloworld

为了实现这些，我们再次开始折腾设备，根据上述设定配置小米路由器青春版（先忽略自定义 ipk），配置完成后，备份并下载，得到备份文件 `backup-OpenWrt-2019-09-11.tar.gz`, 重命名为 `factory-backup-OpenWrt-Xiaomi.tar.gz`, 保存这个备份，作为出厂模式的版本备份。

解压缩备份文件，看一下文件结构

```
etc

├── config
│   ├── dhcp
│   ├── dropbear
│   ├── firewall
│   ├── luci
│   ├── network
│   ├── rpcd
│   ├── system
│   ├── ucitrack
│   ├── uhttpd
│   └── wireless
├── dropbear
│   └── dropbear_rsa_host_key
├── group
├── hosts
├── inittab
├── luci-uploads
├── opkg
│   ├── customfeeds.conf
│   └── keys
├── passwd
├── profile
├── rc.local
├── shadow
├── shells
└── sysctl.conf
```

说明

* `/etc/config/wireless` 无线配置
* `/etc/config/network` 网络配置
* `/etc/config/system` 系统基本配置，如时区、NTP
* `/etc/config/luci` LuCI 配置，如语言、主题
* `/etc/shadow` 加密后的密码
* `/etc/okpg/customfeeds.conf` 自定义软件源
* `/etc/okpg/distfeeds.conf` 发行版软件源

现在，我们在 Mac 上保留这几项配置至 `xiaomi` 这一目录, 上传 `xiaomi` 至 Ubuntu `openwrt-imagebuilder-xiaomi` 目录 (觉得 scp 命令繁琐的话，可以使用 [Cyberduck](https://cyberduck.io/) 这一可视化 scp 工具)

最终，可以确定 小米路由器青春版 `FILES=xiaomi`

### 添加第三方软件包

仅使用官方源仓库中的软件，不能满足我们的需求，有时需要添加一些第三方软件包。安全是第一考量，使用闭源的第三方 ipk，有可能会留有后门，导致不可估量的后果，所以更推荐开源、活跃的第三方软件包。

除了安全性，第三方软件包是否适合自己的硬件也是衡量标准之一。我们需要知道第三方软件包依赖了那些程序、是否支持我们的硬件，通常，这可以在开源仓库的 README 文件中找到指引。

阅读: [使用 SDK 编译特定软件包](https://stuarthua.github.io/oh-my-openwrt/mybook/make-my/make-by-sdk.html) 

接下来，我们来看一个文件 `openwrt-imagebuilder-xiaomi/repositories.conf`, 这对我们接下来的工作有所启发

```
## Place your custom repositories here, they must match the architecture and version.
# src/gz %n http://downloads.openwrt.org/releases/18.06.4
# src custom file:///usr/src/openwrt/bin/ramips/packages

## Remote package repositories
src/gz openwrt_core http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/packages
src/gz openwrt_base http://downloads.openwrt.org/releases/18.06.4/packages/mipsel_24kc/base
src/gz openwrt_luci http://downloads.openwrt.org/releases/18.06.4/packages/mipsel_24kc/luci
src/gz openwrt_packages http://downloads.openwrt.org/releases/18.06.4/packages/mipsel_24kc/packages
src/gz openwrt_routing http://downloads.openwrt.org/releases/18.06.4/packages/mipsel_24kc/routing
src/gz openwrt_telephony http://downloads.openwrt.org/releases/18.06.4/packages/mipsel_24kc/telephony

## This is the local package repository, do not remove!
src imagebuilder file:packages
```

* 本地添加第三方 ipk

由 `src imagebuilder file:packages` 可知，置于 `openwrt-imagebuilder-xiaomi/packages` 目录下的 ipk 包会被直接打包到固件中

编译生成适合自己的第三方 ipk 后，将第三方 ipk 文件挪至 `openwrt-imagebuilder-xiaomi/packages/` 目录下，然后在编译参数 `PACKAGES` 中声明即可

我们也可以指定 ipk 目录，由 `src custom file:///usr/src/openwrt/bin/ramips/packages` 可知，Image Builder 支持添加本地软件包的生成目录，将 ipk 组装到固件中

* 添加信任的第三方软件包仓库

同样，Image Builder 也支持从远程仓库中下载 ipk 包，最后组装到固件中

`repositories.conf` 可以帮助我们统一存放第三方 ipk，免除一些频繁编译 ipk 包的痛苦。

> **注意：** Image Builder 并不能从源码编译，更多时候，它只是一个组装工具，帮助我们将各种 ipk 包组装到固件镜像中。

以 HelloWorld `helloworld` 为例，将 `helloworld.ipk` 文件上传到 `openwrt-imagebuilder-xiaomi/packages` 目录，在编译参数 `PACKAGES` 中添加 `helloworld`

## 开始编译

以上操作无误的话，此时，`openwrt-imagebuilder-xiaomi` 的文件结构为

```bash
openwrt-imagebuilder-xiaomi

├── build_dir
├── include
├── Makefile
├── packages
├── repositories.conf
├── rules.mk
├── scripts
├── staging_dir
├── target
└── xiaomi
```

编译固件

```bash
$ cd openwrt-imagebuilder-xiaomi
$ make image PROFILE=miwifi-nano \
PACKAGES="base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini luci-i18n-base-zh-cn -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport helloworld" \
FILES=xiaomi
```

如果遇到编译失败，尝试运行 `make clean` 清理临时编译文件和生成的镜像，再重新编译

编译成功的话，在 `openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8/` 目录下便可以找到相应的 bin 文件，小米路由器青春版为 `openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin`

## 小结

现在，我们来回顾一下使用 Image Builder 编译定制小米路由器青春版固件的步骤 (不包含第三方软件包): 

Ubuntu 下载 [小米路由器青春版 Image Builder](http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz)，解压并重命名为 `openwrt-imagebuilder-xiaomi`, 存放在用户根目录

```
cd ~
wget http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz
mv openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz openwrt-imagebuilder-xiaomi
rm -rf openwrt-imagebuilder-18.06.4-ramips-mt76x8.Linux-x86_64.tar.xz
```

下载路由器配置备份，存放至 `~/oh-my-openwrt-devices`

```
cd ~
git clone https://github.com/stuarthua/oh-my-openwrt oh-my-openwrt-devices
git checkout -b devices origin/devices
```

终端开启代理 - `startss`, 开始编译

```
cd ~/openwrt-imagebuilder-xiaomi
make image PROFILE=miwifi-nano \
PACKAGES="base-files busybox dnsmasq dropbear firewall fstools fwtool hostapd-common ip6tables iptables iw iwinfo jshn jsonfilter kernel kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ipt-offload kmod-leds-gpio kmod-lib-crc-ccitt kmod-mac80211 kmod-mt76 kmod-mt76-core kmod-mt7603 kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-reject kmod-nf-reject6 kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libnl-tiny libpthread libubox libubus libubus-lua libuci libuclient libxtables logd lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mtd netifd odhcp6c odhcpd-ipv6only openwrt-keyring opkg ppp ppp-mod-pppoe procd rpcd rpcd-mod-rrdns swconfig ubox ubus ubusd uci uclient-fetch uhttpd usign wireless-regdb wpad-mini luci-i18n-base-zh-cn -kmod-usb-core -kmod-usb2 -kmod-usb-ohci -kmod-usb-ledtrig-usbport" \
FILES=~/oh-my-openwrt-devices/devices/xiaomi
```

编译成功的话，在 `openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8/` 目录，我们可以得到固件 `openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin`

固件文件路径过深，为便于查看，可以在用户根目录建立软连接

```bash
$ mkdir -p ~/image-bins
$ ln -s /home/stuart/openwrt-imagebuilder-xiaomi/bin/targets/ramips/mt76x8 /home/stuart/image-bins/xiaomi
```

固件特性：

* 开启无线 WIFI
* 国内时区、NTP
* LuCI 中文语言
* 国内源
* 访问
  * 地址: 192.168.1.1
  * 密码: password
