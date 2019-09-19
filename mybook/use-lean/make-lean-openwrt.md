# 使用恩山论坛 Lean 修改版 OpenWrt

* 源码地址: [Github - coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)

以下记录使用 lean 源码编译 x86 平台的 OpenWrt 固件的过程，仅供参考

## 准备

阅读：[在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](https://stuarthua.github.io/oh-my-openwrt/mac-vmware-install-ubuntu.html)

* Mac
* VMware Fusion 11

## 下载 Lean-OpenWrt 修改版源码

Mac 上 SSH 连接 Ubunut (IP: 192.168.128.140)

```bash
$ ssh stuart@192.168.128.140
```

下载源码

```bash
$ cd ~
$ git clone https://github.com/coolsnowwolf/lede lean-openwrt
```

## 准备编译

更新 Ubuntu

```bash
$ sudo apt-get update
```

安装所需的软件库

```bash
$ sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint
```

### feeds 更新和安装

终端开启代理 - `startss`, 更新 feeds

```bash
$ cd ~/lean-openwrt
$ ./scripts/feeds update -a

# 建议执行多次，成功的话，显示如下
Updating feed 'luci' from 'https://github.com/coolsnowwolf/luci' ...
Already up-to-date.
Create index file './feeds/luci.index'
Updating feed 'packages' from 'https://github.com/coolsnowwolf/packages' ...
Already up-to-date.
Create index file './feeds/packages.index'
Updating feed 'routing' from 'https://git.openwrt.org/feed/routing.git;openwrt-18.06' ...
Already up-to-date.
Create index file './feeds/routing.index'
```

安装 feeds

```bash
$ ./scripts/feeds install -a

# 建议执行多次，成功的话，显示如下
Collecting package info: done
Installing all packages from feed luci.
Installing all packages from feed packages.
Installing all packages from feed routing.
```

## 编译设置

进行编译设置

```bash
$ make menuconfig
```

* Target System: x86
* Subtarget: x86_64
* Target Profile: Generic
* Target Images: 勾选 squashfs

保存设置

> **提示：** `~/lean-openwrt` 目录下隐藏文件 `.config` 存放的便是 `make menuconfig` 的设置，删除这个文件，即可恢复默认设置

## 开始编译

终端开启代理 - `startss`, 下载编译所需依赖

```bash
$ make download V=99
```

> **注意：** 下载的依赖文件存放在 `~/lean-openwrt/dl` 目录，检查该目录，如果有文件小于 1K，可认为下载失败，删除后重新执行 download

### 编译固件

执行首次编译，生成固件

```bash
$ make V=99
```

编译成功的话，会生成所选 Target 的固件和软件包

编译产物均在 `~/lean-openwrt/bin` 目录下可以找到，根据不同的硬件平台类型按文件夹分类

> **提示：** 之后的编译，因为已经完整下载了依赖并生成 toolchain, 速度相对会快一些。

### 编译特定软件包

以第三方软件包 `helloworld` 为例

```bash
$ make package/helloworld/compile V=99
```

## 使用

访问地址：

* 地址：192.168.1.1
* 密码：password

查看默认安装的包：

```bash
$ echo $(opkg list_installed | awk '{ print $1 }')

adbyby alsa-lib alsa-utils amd64-microcode ath10k-firmware-qca9888 ath10k-firmware-qca988x ath10k-firmware-qca9984 ath9k-htc-firmware autocore automount autosamba base-files bash bc block-mount bnx2-firmware brcmfmac-firmware-43602a1-pcie busybox ca-certificates coremark coreutils coreutils-base64 coreutils-nohup ddns-scripts ddns-scripts_aliyun default-settings dnsmasq-full dropbear e2fsprogs etherwake ethtool fdisk firewall fstools fwtool hostapd-common htop intel-microcode ip-full ipset iptables iptables-mod-conntrack-extra iptables-mod-fullconenat iptables-mod-ipopt iptables-mod-ipsec iptables-mod-tproxy iw iwinfo jshn jsonfilter kernel kmod-ac97 kmod-asn1-decoder kmod-ath kmod-ath10k kmod-ath5k kmod-ath9k kmod-ath9k-common kmod-ath9k-htc kmod-bnx2 kmod-bonding kmod-button-hotplug kmod-cfg80211 kmod-crypto-acompress kmod-crypto-aead kmod-crypto-authenc kmod-crypto-cbc kmod-crypto-crc32c kmod-crypto-deflate kmod-crypto-des kmod-crypto-ecb kmod-crypto-echainiv kmod-crypto-hash kmod-crypto-hmac kmod-crypto-iv kmod-crypto-manager kmod-crypto-md5 kmod-crypto-null kmod-crypto-pcompress kmod-crypto-rng kmod-crypto-sha1 kmod-crypto-sha256 kmod-crypto-wq kmod-e1000 kmod-e1000e kmod-fs-exfat kmod-fs-ext4 kmod-fs-vfat kmod-fuse kmod-gre kmod-hid kmod-hid-generic kmod-hwmon-core kmod-i2c-algo-bit kmod-i2c-core kmod-i40e kmod-i40evf kmod-ifb kmod-igb kmod-igbvf kmod-input-core kmod-input-evdev kmod-ip6tables kmod-ipsec kmod-ipsec4 kmod-ipsec6 kmod-ipt-conntrack kmod-ipt-conntrack-extra kmod-ipt-core kmod-ipt-fullconenat kmod-ipt-ipopt kmod-ipt-ipsec kmod-ipt-ipset kmod-ipt-nat kmod-ipt-offload kmod-ipt-raw kmod-ipt-tproxy kmod-iptunnel kmod-iptunnel4 kmod-iptunnel6 kmod-ixgbe kmod-lib-crc-ccitt kmod-lib-crc16 kmod-lib-textsearch kmod-lib-zlib-deflate kmod-lib-zlib-inflate kmod-libphy kmod-mac80211 kmod-mdio kmod-mii kmod-mppe kmod-nf-conntrack kmod-nf-conntrack-netlink kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-nathelper kmod-nf-nathelper-extra kmod-nf-reject kmod-nf-reject6 kmod-nfnetlink kmod-nls-base kmod-nls-cp437 kmod-nls-iso8859-1 kmod-nls-utf8 kmod-pcnet32 kmod-phy-realtek kmod-ppp kmod-pppoe kmod-pppox kmod-pps kmod-ptp kmod-r8169 kmod-regmap-core kmod-rt2800-lib kmod-rt2800-usb kmod-rt2x00-lib kmod-rt2x00-usb kmod-sched-cake kmod-sched-core kmod-scsi-core kmod-slhc kmod-sound-core kmod-sound-hda-codec-realtek kmod-sound-hda-codec-via kmod-sound-hda-core kmod-sound-mpu401 kmod-sound-via82xx kmod-tcp-bbr kmod-tulip kmod-tun kmod-usb-audio kmod-usb-core kmod-usb-hid kmod-usb-net kmod-usb-net-asix kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8150 kmod-usb-net-rtl8152 kmod-usb-printer kmod-usb-storage kmod-usb-storage-extras kmod-vmxnet3 libblkid libblobmsg-json libc libcares libcomerr libelf libev libext2fs libf2fs libfdisk libgcc libgmp libip4tc libip6tc libipset libiwinfo libiwinfo-lua libjson-c libjson-script liblua liblucihttp liblucihttp-lua libmbedtls libminiupnpc libmnl libnatpmp libncurses libnl-tiny libopenssl libpcre libpthread libreadline librt libsensors libsmartcols libsodium libss libstdcpp libsysfs libubox libubus libubus-lua libuci libuclient libustream-openssl libuuid libxtables lm-sensors logd lua luci luci-app-accesscontrol luci-app-adbyby-plus luci-app-arpbind luci-app-autoreboot luci-app-ddns luci-app-filetransfer luci-app-firewall luci-app-flowoffload luci-app-ipsec-vpnd luci-app-nlbwmon luci-app-pptp-server luci-app-ramfree luci-app-samba luci-app-sqm luci-app-ssr-plus luci-app-upnp luci-app-usb-printer luci-app-vlmcsd luci-app-vsftpd luci-app-wifischedule luci-app-wol luci-app-xlnetacc luci-app-zerotier luci-base luci-i18n-accesscontrol-zh-cn luci-i18n-adbyby-plus-zh-cn luci-i18n-arpbind-zh-cn luci-i18n-autoreboot-zh-cn luci-i18n-base-zh-cn luci-i18n-ddns-zh-cn luci-i18n-filetransfer-zh-cn luci-i18n-firewall-zh-cn luci-i18n-flowoffload-zh-cn luci-i18n-ipsec-vpnd-zh-cn luci-i18n-nlbwmon-zh-cn luci-i18n-pptp-server-zh-cn luci-i18n-ramfree-zh-cn luci-i18n-samba-zh-cn luci-i18n-upnp-zh-cn luci-i18n-usb-printer-zh-cn luci-i18n-vlmcsd-zh-cn luci-i18n-vsftpd-zh-cn luci-i18n-wifischedule-zh-cn luci-i18n-wol-zh-cn luci-i18n-zerotier-zh-cn luci-lib-fs luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full luci-proto-bonding luci-proto-ppp luci-theme-bootstrap miniupnpd mkf2fs mtd netifd nlbwmon ntfs-3g openssl-util openwrt-keyring opkg p910nd partx-utils pdnsd-alt ppp ppp-mod-pppoe pptpd procd proto-bonding r8169-firmware rpcd rpcd-mod-rrdns rt2800-usb-firmware samba36-server shadowsocks-libev-config shadowsocks-libev-ss-redir shadowsocksr-libev-alt shadowsocksr-libev-server shadowsocksr-libev-ssr-local shellsync sqm-scripts strongswan strongswan-charon strongswan-ipsec strongswan-minimal strongswan-mod-aes strongswan-mod-gmp strongswan-mod-hmac strongswan-mod-kernel-netlink strongswan-mod-nonce strongswan-mod-pubkey strongswan-mod-random strongswan-mod-sha1 strongswan-mod-socket-default strongswan-mod-stroke strongswan-mod-updown strongswan-mod-x509 strongswan-mod-xauth-generic strongswan-mod-xcbc sysfsutils tc terminfo ubox ubus ubusd uci uclient-fetch uhttpd uhttpd-mod-ubus usign v2ray vlmcsd vsftpd-alt wget wifischedule wireless-regdb wpad zerotier zlib
```

## 后续

如果想要对固件进行修改，可以考虑编译时，选中生成 Image Builder 和 SDK，之后使用 SDK 编译特定软件包，使用 Image Builder 生成完整固件。

