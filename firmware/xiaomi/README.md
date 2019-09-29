# README

适用于 `小米路由器青春版` 的固件及配置备份文件

刷写固件参考 - [小米路由器青春版使用官方 OpenWrt](https://stuarthua.github.io/oh-my-openwrt/mybook/first-use/use-official-openwrt-on-xiaomi-nano.html)

## 官方固件

* `openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin`

OpenWrt 18.06.4 官方固件 - `openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin` 

下载地址: [http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin](http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin)

* 无中文语言
* 默认不开启 WIFI
* 时区、NTP 均为国外
* 国外软件源

## Stuart 定制版出厂固件

### 定制版 OpenWrt 出厂固件

定制版 OpenWrt 18.06.4 固件 - `Stuart-factory-OpenWrt-Xiaomi.bin`

访问地址：

* 默认地址: 192.168.1.1
* 默认密码: password

特性：

* 中文语言
* 默认开启 WIFI
* 国内时区、NTP
* 国内软件源
* Shadowsocks + GFWList 自动翻墙
* 官方软件包
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
    * `libustream-openssl` - support for https
    * `ca-bundle` - support for https
    * `ca-certificates` - support for https
    * `curl` - 下载工具
    * `wget` - 下载工具
    * `vsftpd` - for sftp
    * `openssh-sftp-server` - for sftp
    * `ipset` - for shadowsocks gfwlist
    * `iptables-mod-nat-extra` - for shadowsocks gfwlist
    * `dnsmasq-full` - for shadowsocks gfwlist, 与 `dnsmasq` 相冲突，需要忽略 `dnsmasq`
    * `iptables-mod-tproxy` - for shadowsocks UDP-Relay
    * `ttyd` - 网页命令行终端
* 第三方软件包
    * `luci-app-ramfree` - 释放内存
    * `luci-app-fileassistant` - 文件助手，支持上传文件、安装 IPK 软件包
    * `luci-app-arpbind` - IP/Mac 绑定
        * `luci-i18n-arpbind-zh-cn` - 软件包 `luci-app-arpbind` 的中文语言包
    * `luci-app-autoreboot` - 定时重启
        * `luci-i18n-autoreboot-zh-cn` - 软件包 `luci-app-autoreboot` 的中文语言包
    * `luci-app-vlmcsd` - KMS 服务器，用于激活 Windows 及 Office
        * `vlmcsd` - KMS Server
    * `luci-app-ttyd` - LuCI for ttyd
        * `luci-i18n-ttyd-zh-cn` - 软件包 `luci-app-ttyd` 的中文语言包
    * `luci-app-shadowsocks` - LuCI for Shadowsocks
        * `shadowsocks-libev` - shadowsocks-libev
    * `luci-app-chinadns` - LuCI for ChinaDNS
        * `ChinaDNS` - ChinaDNS
    * `luci-app-dns-forwarder` - LuCI for DNS Forwarder
        * `dns-forwarder` - DNS Forwarder
    * ~~`luci-i18n-sqm` - 软件包 `luci-app-sqm` 的中文语言包~~

### 定制版出厂包的备份文件

定制版出厂包的备份文件 - `backup-Stuart-factory-OpenWrt-Xiaomi.tar.gz`