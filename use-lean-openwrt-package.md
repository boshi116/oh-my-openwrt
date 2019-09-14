---
title: 使用恩山论坛 Lean 修改版 OpenWrt 软件包
parent: 使用恩山论坛 Lean 修改版 OpenWrt
nav_order: 2
---

# 使用恩山论坛 Lean 修改版 OpenWrt 软件包

以下列出恩山论坛 Lean 修改版 OpenWrt 的一些软件包，更多详情可见 [恩山论坛: OpenWrt 编译 LuCI -> Applications 添加插件应用说明](https://www.right.com.cn/forum/thread-344825-1-1.html)

## 软件包

* 内核

| Package | 描述 | 说明 |
| ---- | ---- | ---- |
| kmod-nf-nathelper | NAT 以及防火墙，包含 FTP | https://openwrt.org/packages/pkgdata/kmod-nf-nathelper |
| kmod-nf-nathelper-extra | NAT 以及防火墙拓展，包含 PPTP、广播等 | https://openwrt.org/packages/pkgdata/kmod-nf-nathelper-extra |
| kmod-ipt-raw | IPv4 原始表支持 | https://openwrt.org/packages/pkgdata/kmod-ipt-raw |
| kmod-ipt-raw6 | IPv6 原始表支持 | https://openwrt.org/packages/pkgdata/kmod-ipt-raw6 |
| kmod-tcp-bbr | tcp bbr 加速 | 官网最新版查询没有，但在一些其他版本分支上存在 |
| kmod-ipt-offload | NAT 加速 | https://openwrt.org/packages/pkgdata/kmod-ipt-offload |
| kmod-usb-hid | 内核支持 USB HID 设备，如键盘和鼠标 | https://openwrt.org/packages/pkgdata/kmod-usb-hid |
| kmod-ath5k | 高通 Atheros 5xxx 芯片组的无线适配器支持 | https://openwrt.org/packages/pkgdata/kmod-ath5k |
| kmod-ath9k | 高通 Atheros IEEE 802.11n AR5008和AR9001 系列芯片组的无线适配器支持| https://openwrt.org/packages/pkgdata/kmod-ath9k |
| kmod-ath9k-htc | 高通 Atheros USB AR9271 和 AR7010 系列芯片组的无线适配器支持 | https://openwrt.org/packages/pkgdata/kmod-ath9k-htc |
| kmod-ath10k | 高通 Atheros IEEE 802.11ac 系列芯片组的无线适配器的支持，目前仅支持 PCI | https://openwrt.org/packages/pkgdata/kmod-ath10k |
| kmod-rt2800-usb | RT2x00 卡的 Ralink 驱动程序（RT2870 USB） | https://openwrt.org/packages/pkgdata/kmod-rt2800-usb |
| kmod-e1000e | 用于英特尔（R）PRO / 1000 PCIe 以太网适配器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-e1000e |
| kmod-igb | 用于英特尔（R）82575/82576 PCI-Express 千兆以太网适配器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-igb |
| kmod-igbvf | 用于英特尔（R）82576 虚拟功能以太网适配器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-igbvf |
| kmod-ixgbe | 用于英特尔（R）82598/82599 PCI-Express 10千兆位以太网适配器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-ixgbe |
| kmod-pcnet32 | AMD PCnet32 以太网适配器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-pcnet32 |
| kmod-tulip | Tulip系列网卡的内核模块， 包括DECchip Tulip，DIGITAL EtherWORKS，Winbond W89c840， Davicom DM910x / DM980x和ULi M526x控制器支持 | https://openwrt.org/packages/pkgdata/kmod-tulip |
| kmod-vmxnet3 | 适用于VMware VMXNET3以太网适配器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-vmxnet3 |
| kmod-i40e kmod-i40evf | Intel i40e i40evf 驱动程序| 官方没有收录，Lean 仓库中有收录 |
| kmod-ac97 | ac97 控制器 | https://openwrt.org/packages/pkgdata/kmod-ac97 |
| kmod-sound-hda-core | 用于HD Audio声音支持的内核模块 | https://openwrt.org/packages/pkgdata/kmod-sound-hda-core |
| kmod-sound-hda-codec-realtek | 用于Intel HDA Realtek编解码器支持的内核模块 | https://openwrt.org/packages/pkgdata/kmod-sound-hda-codec-realtek |
| kmod-sound-hda-codec-via | 用于HD Audio VIA编解码器支持的内核模块 | https://openwrt.org/packages/pkgdata/kmod-sound-hda-codec-via |
| kmod-sound-via82xx | 支持主板上集成的AC97声音设备 使用威盛芯片组 | https://openwrt.org/packages/pkgdata/kmod-sound-via82xx |
| kmod-usb-audio | 内核支持USB音频设备 | https://openwrt.org/packages/pkgdata/kmod-usb-audio |
| kmod-usb-net | 用于USB转以太网转换器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-usb-net |
| kmod-usb-net-asix | 用于USB转以太网Asix转换器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-usb-net-asix |
| kmod-usb-net-asix-ax88179 | 用于USB转以太网ASIX AX88179的USB 3.0 / 2.0内核模块 千兆以太网适配器 | https://openwrt.org/packages/pkgdata/kmod-usb-net-asix-ax88179 |
| kmod-usb-net-rtl8150 | 用于USB到以太网的Realtek 8150转换器的内核模块 | https://openwrt.org/packages/pkgdata/kmod-usb-net-rtl8150 |
| kmod-usb-net-rtl8152 | 用于USB到以太网的内核模块Realtek 8152 USB2.0 / 3.0转换器 | https://openwrt.org/packages/pkgdata/kmod-usb-net-rtl8152 |

关于内核软件包的更多信息可在官网中查到：[https://openwrt.org/packages/table/start](https://openwrt.org/packages/table/start)

* luci

| Package | 描述 | 说明 |
| ---- | ---- | ---- |
| luci | OpenWRT Web 管理 |  |
| luci-app-ddns | DDNS |  |
| luci-app-sqm | 流量智能队列管理(QOS) |  |
| luci-app-upnp | 通用即插即用 UPnP(端口自动转发) |  |
| luci-app-adbyby-plus | 广告屏蔽大师 Plus + |  |
| luci-app-autoreboot | 支持计划重启 |  |
| luci-app-filetransfer | 文件传输 |  |
| luci-app-ssr-plus | SSR 代理 |  |
| luci-app-vsftpd | FTP 服务器（更安全） |  |
| ddns-scripts_aliyun | 阿里云 DDNS |  |
| luci-app-pptp-server | PPTP VPN Server |  |
| luci-app-arpbind | IP/MAC 绑定 |  |
| luci-app-vlmcsd | 微软激活正版 KMS 服务器设置 |  |
| luci-app-wifischedule | WiFi 计划 |  |
| luci-app-wol | WOL 网络唤醒 |  |
| luci-app-ramfree | 释放内存 |  |
| luci-app-sfe | Turbo ACC 网络加速(开启Fast Path转发加速) | https://www.right.com.cn/forum/thread-341935-1-1.html |
| luci-app-flowoffload | Turbo ACC FLOW 转发加速 |  |
| luci-app-nlbwmon | 网络带宽监视器 |  |
| luci-app-usb-printer | USB 打印服务器 |  |
| luci-app-accesscontrol | 访问时间控制 |  |
| luci-app-zerotier | ZeroTier 内网穿透 |  |
| luci-app-xlnetacc | 迅雷快鸟 |  |
| luci-app-ipsec-vpnd | IPsec VPN |  |
| luci-proto-bonding | 支持链路聚合 802.3ad |  |

> **注意：** 更多 Lean 的软件包说明，详见：[https://www.right.com.cn/forum/thread-344825-1-1.html](https://www.right.com.cn/forum/thread-344825-1-1.html)

* 其他

| Package | 描述 | 说明 |
| ---- | ---- | ---- |
| block-mount | 启动时 USB 自动挂载 | |
| coremark | 测试处理器核心性能 |  |
| wget | Linux 命令：下载 |  |
| libustream-openssl | SSL 支持 |  |
| ca-certificates | SSL 证书颁发机构 |  |
| default-settings | 默认设置 |  |
| fdisk | Linux 命令：磁盘分区 |  |
| lsblk | Linux 命令：列出所有可用块设备的信息 |  |
| mdadm | Linux 命令：管理和监视软件RAID设备 |  |
| automount | 自动挂载服务 |  |
| autosamba | 自动挂载 samba |  |
| dnsmasq | 提供 DNS 缓存和 DHCP 服务 |  |
| dnsmasq-full | 支持 ipset 的 dnsmasq，适合国内| https://www.ixsh.com/tag/dnsmasq-full/ |
| iptables | IPv4 防火墙 |  |
| ip6tables | IPv6 防火墙 |  |
| ppp、ppp-mod-pppoe | pppoe 拨号 |  |
| odhcp6c | DHCPv6 客户端 | https://openwrt.org/docs/techref/odhcp6c |
| odhcpd-ipv6only | 为IP配置客户端和下游路由器提供IP服务和中继服务 | https://openwrt.org/packages/pkgdata/odhcpd-ipv6only |
| partx-utils | Linux 工具：磁盘管理 |  |
| mkf2fs | Linux 工具：磁盘格式化 |  |
| e2fsprogs | Linux 工具：维护 ext2，ext3 和 ext4 文件系统 |  |
| wpad | 让浏览器自动发现代理服务器 | https://www.ibm.com/developerworks/cn/linux/1309_quwei_wpad/index.html |
| htop | Linux 命令：查看进程及其命令 | https://openwrt.org/packages/pkgdata/htop |
| lm-sensors | 读取硬件传感器数据 | https://openwrt.org/packages/pkgdata/lm-sensors |
| autocore automount autosamba | Lean 自定义程序 |  |
| ath10k-firmware-qca988x | 适用于QCA988x器件的ath10k固件 | https://openwrt.org/packages/pkgdata/ath10k-firmware-qca988x-ct |
| ath10k-firmware-qca9888 | 适用于QCA9888器件的ath10k固件 | https://openwrt.org/packages/pkgdata/ath10k-firmware-qca9888 |
| ath10k-firmware-qca9984 | 适用于QCA9884器件的ath10k固件 | https://openwrt.org/packages/pkgdata/ath10k-firmware-qca9984 |
| brcmfmac-firmware-43602a1-pcie | Broadcom 43602a1 FullMAC PCIe固件 | https://openwrt.org/packages/pkgdata/brcmfmac-firmware-43602a1-pcie |
| intel-microcode | Intel x86 CPU 微指令 | https://openwrt.org/packages/pkgdata/intel-microcode |
| amd64-microcode | AMD64 CPU 微指令 | https://openwrt.org/packages/pkgdata/amd64-microcode |
| alsa-utils | ALSA（高级Linux声音架构）工具 | https://openwrt.org/packages/pkgdata/alsa-utils |
| shadowsocks-libev-ss-redir v2ray shadowsocksr-libev-server shadowsocksr-libev-ssr-local | 科学上网 |  |