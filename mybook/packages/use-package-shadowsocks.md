# 移植软件包 - 科学上网

科学上网，是一个比较庞杂的概念，涉及的领域不仅局限于代理工具 shadowsocks、v2ray, 还有诸如加密算法、DNS 防污染、分流等分支概念。

以下记录自己使用一段时间后，觉得比较稳定的方案。

## 方案

一般而言，用户直观使用的方案即是代理工具（shadowsocks、v2ray），就目前而言，这些开源项目已经发展地足够成熟，可以很方便的被广大受众所接受并使用。对于移动终端，如手机、笔记本，因为上网环境可能随时变动，选择代理工具，在有需要的时候进行代理，是一种很方便实用的使用方式。

但在路由器上，因为终端功能特殊，作为一个为其他设备提供上网环境的设备，频繁的开启代理或者修改一些配置，显得不那么适用。所以路由器上设置翻墙，还是要确定最终需求，即 对自己指定的站点进行代理，并且支持方便的自定义。

梳理一下实现最终需求所需的步骤：

* 代理工具 (shadowsocks、v2ray) 可实现代理翻墙，但工具本身只支持全局翻墙
* 要实现依据 gfwlist 域名列表自动代理，本质上依然是根据 IP 判断是否走代理，可以使用 ipset 将 DNS 解析域名得到的 IP 添加到自定义规则集中，该规则集强制走代理
* 国内 DNS 解析污染严重，对于国外域名，很多并不会返回正确的 IP，可以使用如 ChinaDNS 类似的防污染工具，保证 DNS 正确解析。

## shadowsocks

最终效果预览：

![Snipaste_2019-09-19_23-50-11.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-19_23-50-11.png)

修改版源码见: 

* [stuart/shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/shadowsocks)
* [stuart/luci-app-shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-shadowsocks)

修改说明: 

* 修改 LuCI 菜单目录
* 只编译 luci-app-shadowsocks (含 ipset)
* 只编译 shadowsocks-libev 客户端版本

### 使用

[shadowsocks/shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev) 是至今仍在维护的一个项目，其本身是基于 libev 事件库开发的 shadowsocks 代理套件。

主要组件为：

* `ss-local` - 客户端程序
* `ss-server` - 服务端程序
* `ss-redir` - socks5 透明代理工具，将客户端的原始数据封装成 shadowsocks 协议内容，转发给服务器
* `ss-tunnel` - 本地端口转发工具，可用于解决 dns 污染问题

正常情况下，访问一个站点（如百度），经历的流程比较简单，依次是

1. 向 DNS 服务器请求解析，得到站点所在服务器 IP
2. 同站点所在服务器 IP 建立连接，得到所访问的内容（如 html 网页、图片等）

非正常情况（被墙）下，访问一个站点，情况就复杂的多。需要区分场景，判断哪些站点走代理，哪些站点直接连接。

以下介绍几种常见方案

#### 方案一

> **说明：** 该方案并不能解决 DNS 污染的问题，只能保证访问 gfw 列表内的站点强制走代理，访问其他站点走直接连接，从而达到自动翻墙的目的。能够容忍 DNS 污染的用户，可以考虑此方案，因为比较稳定，且需要设置的内容也比较少，使用比较方便。

使用到的开源项目：

* [stuart/shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/shadowsocks)
* [stuart/luci-app-shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-shadowsocks)

工作原理：

* dnsmasq + ipset
* shadowsocks

图文设置过程：

[TODO]

访问站点的过程：

[TODO]

#### 方案二

> **说明：** 该方案可以一定程度上解决 DNS 污染的问题，同时支持 gfwlist 模式，即访问 gfw 列表内的站点强制走代理，访问其他站点走直接连接，自动翻墙。如果使用该方案解决 DNS 污染的方式不稳定，影响使用，请考虑其他方案。

很多情况下，GFW 对特定站点的干扰主要有以下几个级别：

1. 随机丢包、限速
2. 域名阻断、IP 阻断
3. DNS 干扰

一般被墙站点都基本上处于 1 或 2，但对于 Google、Facebook 等站点，GFW 则使用了 DNS 解析污染。DNS 发展最初，出于性能和速度的考虑，使用了 UDP 这种不可靠的协议，这就使得 DNS 解析污染很容易出现，即被中间路由截获并返回了虚假的 IP 地址。DNS 污染，并不是国内特有的现象，在世界范围内也十分普遍，所以目前已经有很多解决方案，如基于 TLS 的 DNS 解析 DoT (DNS-over-TLS)、基于 Https 的解析 DoH (DNS over Https)。

DNS 防污染，追根溯源可以理解为对 DNS 解析过程的安全强化，先后出现的几种协议也是为了保障这一点（[对比4种强化域名安全的协议——DNSSEC，DNSCrypt，DNS over TLS，DNS over HTTPS](https://program-think.blogspot.com/2018/10/Comparison-of-DNS-Protocols.html)）。目前, Firefox 已默认使用 DoH, Chrome 在最新版本中也在测试 DoH，同时，DoH 标准也被 IETF（互联网工程任务组）正式采用，即便这遭到了 DNS 之父 Paul Vixie 的炮轰，因为 DoH 与 DNS 的基本架构不相兼容，DoH 将控制平面（信令）消息转移到了数据平面（消息转发），而这是一大禁忌，有兴趣的可以阅读 [原文](https://www.secrss.com/articles/5898)。也可以尝试在本地自建 DNS 服务器，体验一下 DoT、DoH，参考 [除了 DNSCrypt，你还可以了解一下更好的 DNS 加密方案 - DoT DoH](https://www.logcg.com/archives/3127.html)。

拉回正题，以下介绍路由器上使用 ChinaDNS 分流方案防止 DNS 污染、结合 shadowsocks 代理翻墙的过程。

使用到的开源项目：

* [aa65535/openwrt-chinadns](https://github.com/aa65535/openwrt-chinadns)
* [aa65535/openwrt-dns-forwarder](https://github.com/aa65535/openwrt-dns-forwarder)
* [stuart/shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/shadowsocks)
* [stuart/luci-app-shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-shadowsocks)

工作原理：

* 假设所有被污染域名都解析到非国内 IP
* ChinaDNS 配置至少两个上游 DNS (一个为国内 DNS，一个为国外 DNS)，默认国外 DNS 是可信的 DNS 服务器（至少比国内可信）
* 当解析一个域名时，ChinaDNS 会同时向这些 DNS 服务器发送解析请求，如果国内 DNS 返回的地址是国外的，则过滤掉这个结果，使用国外 DNS 返回的地址，做到智能解析
* Chinadns 只能解决目标是对的问题，要解决路径是通的，就得靠隧道，即代理
* 使用 shadowsocks 代理

图文设置过程：

[TODO]

访问站点的过程：

1. 向 DNS 服务器请求解析，得到站点所在服务器 IP，但因为 DNS 污染，此时得到的 IP 有可能是假的 IP。为了解决这一问题，可以使用 `ss-tunnel` 将 DNS 请求转发至国外的 DNS 服务器（如 Google DNS）。
2. 但仅使用 `ss-tunnel` 的话，访问诸如 `www.taobao.com` 类似的国际型站点，便会返回一个国外的 IP，即跳转到 `world.taobao.com` 淘宝全球站，这与我们的初衷背道而驰，同时，全部使用国外 DNS 服务器，延迟较高，很大程度上拖累我们的网速。为了解决这一问题，可以搭配使用 `ChinaDNS` 配置至少两个上游 DNS (一个为国内 DNS，一个为国外 DNS)，当解析一个域名时，会同时向这些 DNS 服务器发送解析请求，如果国内 DNS 返回的地址是国外的，则过滤掉这个结果，使用国外 DNS 返回的地址，做到智能解析。此时，`ss-tunnel` 作为 `ChinaDNS` 的国外上游 DNS 服务器，使用的是 UDP 协议
3. 使用 `ss-tunnel` 转发进行 DNS 解析，绕的路比较远，所以普遍解析偏慢，至少 80 ms，同时也有一些区域运营商 UDP 不稳定，导致使用 `ss-tunnel` 代理解析的工作完成的不够出色。为了解决这一问题，可以使用 [dnsforwarder](https://github.com/aa65535/openwrt-dns-forwarder) 替代 `ss-tunnel` 作为 `ChinaDNS` 的上游服务器。`dnsforwarder` 使用的是 TCP 协议（阅读：[抛弃 UDP， 用 TCP 查询 DNS
](https://v2mm.tech/topic/711/%E6%8A%9B%E5%BC%83-udp-%E7%94%A8-tcp-%E6%9F%A5%E8%AF%A2-dns) 一文，便于理解）
4. 以上步骤完成的工作只是得到了访问 `youtube.com` 需要走代理的正确 IP，之后的工作便需要与该 IP 建立连接，实现访问，但因为 GFW 封禁了该 IP，国内网络无法与该 IP 建立连接。为了解决这一问题，可以使用 `ss-redir` 透明代理，与 `youtube.com` 服务器 IP 建立连接，最终实现访问。

以上只是理论上讲解代理访问的过程，实际使用时，需要区分正常访问和代理访问，一是为了节省流量开销，二是为了获得国内 CDN 的加速（包括访问诸如 Apple、Microsof 等站点时）。可以使用 `dnsmasq-full` 对域名设置 ipset 规则，从而实现强制某些域名走代理（如 gfwlist）。

> **注意：** ChinaDNS 并不是一个能完美地解决 DNS 污染的工具，它能够完美工作的前提是：假设所有被污染域名都解析到非国内 IP。但这并不完全成立，已有用户反馈出现了 GFW 劫持到国内 IP 的情况（详见：[aa65535/openwrt-chinadns/issues/24](https://github.com/aa65535/openwrt-chinadns/issues/24)）。且开发者 [clowwindy](https://github.com/clowwindy) 已不再更新该项目，在 OpenWrt 上对该项目进行移植的开发者 [aa65535](https://github.com/aa65535/) 也表示不再维护移植项目，而是转而将重心倾注在 v2ray 上。有很多用户反馈使用一段时间后，国外 DNS 解析完全没有返回的情况，导致国外网站全部无法访问（详见：[aa65535/openwrt-chinadns/issues/14](https://github.com/aa65535/openwrt-chinadns/issues/14)）。总体来说，一个不再维护的项目，出现一些玄学现象，除了用户配置错误的情况，能否使用完全取决于用户耐心。

#### 方案三

除了 ChinaDNS, 当然还有其他工具可以选择，如 [shawn1m/overture](https://github.com/shawn1m/overture), [chengr28/Pcap_DNSProxy](https://github.com/chengr28/Pcap_DNSProxy), [felixonmars/dnsmasq-china-list](https://github.com/felixonmars/dnsmasq-china-list) 等，可以阅读 [防污染 DNS 的一点想法](https://blog.bgme.me/posts/some-ideas-about-anti-pollution-dns-server/) ，[求推荐靠谱的防 dns 污染方案](https://www.v2ex.com/t/451599) 这两篇文章，方便理解。

## 说明

移植自 shadowsocks 社区 - [https://github.com/shadowsocks/](https://github.com/shadowsocks/)

* [shadowsocks/openwrt-shadowsocks](https://github.com/shadowsocks/openwrt-shadowsocks)
* [shadowsocks/luci-app-shadowsocks](https://github.com/shadowsocks/luci-app-shadowsocks)

依赖详见 shadowsocks 社区 github

## luci-app-puredns

防 DNS 污染。搭配 chinadns, dns-forwarder 使用

luci-app-chinadns 效果预览：

![Snipaste_2019-09-20_06-40-59.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/tmp/Snipaste_2019-09-20_06-40-59.png)

luci-app-dns-forwarder 效果预览：

![Snipaste_2019-09-20_06-40-42.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/tmp/Snipaste_2019-09-20_06-40-42.png)

移植自 [aa65535/openwrt-dist-luci](https://github.com/aa65535/openwrt-dist-luci)

修改说明：

* 修改 PKG_NAME
* 修改 LuCI 菜单目录
* 只使用 chinadns, dns-forwarder

更多描述，详见: [移植软件包 - 科学上网](https://stuarthua.github.io/oh-my-openwrt/mybook/packages/use-package-shadowsocks.html)