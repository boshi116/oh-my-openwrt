# 使用 x86 固件

以下介绍如何使用个人定制版 x86 固件

固件下载地址：[stuarthua/firmwares/x86](https://github.com/stuarthua/oh-my-openwrt/tree/devices/firmwares/x86)

OpenWrt 与企业级路由器的使用基本一致，但可自定义的功能更多。一般而言，家庭里已经有一台性能不错的路由器，使用 OpenWrt 时，作旁路由（旁路网关）使用即可，可以设定去广告、科学上网等功能，所有流量都经过 OpenWrt 过滤。OpenWrt 作旁路由（旁路网关）时，原主路由的 Qos 功能会显示所有流量都经由 OpenWrt，查看时会有些许复杂，需要一一查找。而使用 OpenWrt 作主路由使用的话，原路由器作二级路由即可，所有的设定均可延续，无需重新设置。

OpenWrt 路由器的工作模式，依照个人场景进行选择即可。

## 作主路由使用

OpenWrt 作为主路由。适用于 OpenWrt 路由器有多个网口的情况。

### 无公网 IP

OpenWrt 路由器连接光猫即可，默认配置即可

LuCI ---> 网络 ---> 接口 ---> WAN

![Snipaste_2019-10-03_14-10-59.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-10-03_14-10-59.png)

### 有公网 IP

光猫已经设置桥接可以获取公网 IP 的话，可以在 OpenWrt 路由器上进行拨号

LuCI ---> 网络 ---> 接口 ---> WAN

![Snipaste_2019-10-03_14-07-49.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-10-03_14-07-49.png)

### ipv6

IPS 下发 ipv6 地址的话，OpenWrt 路由器会自动为子设备提供 ipv6 地址；

如果 ISP 没有下发 ipv6 地址的话，也可以禁用 ipv6

![Snipaste_2019-10-03_14-15-43.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-10-03_14-15-43.png)

## 作旁路由使用

OpenWrt 作旁路由（旁路网关），适用于 OpenWrt 路由器只有一个网口的情况，只做 lan 口使用，连接主路由 lan 口。

假设主路由 ip: 192.168.1.1, OpenWrt ip: 192.168.1.2

### 使用运营商 DNS

一般而言，运营商 DNS 的线路优化比起第三方 DNS 都比较好，不考虑 DNS 污染的情况下，可以使用默认设定，即使用运营商 DNS。这种情况下，无法获取纯净 DNS，也就无法使用科学上网。

* 设置主路由网关、DNS 为 192.168.1.2
* 设置 OpenWrt 路由器网关、DNS 为 192.168.1.1

### 自定义 DNS

自定义 DNS 一般是为了使用纯净 DNS，防止运营商 DNS 投毒或污染（如广告、GFW 干扰）。这种情况下，可以设置去广告、科学上网等功能。

* 设置主路由网关、DNS 为 192.168.1.2
* 设置 OpenWrt 路由器网关为 192.168.1.1；DNS 设置为自定义的 DNS 服务器

详见 [OpenWrt 使用 Shadowsocks ChinaDNS](https://stuarthua.github.io/on-the-way/mybook/proxy-tools/shadowsocks-client-router.html)