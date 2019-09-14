---
title: 移植软件包 - 管控
parent: 使用软件包
nav_order: 6
---

# 移植软件包 - 管控

最终效果预览：

修改版源码见: 

* [stuart/luci-app-control-webrestriction](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-control-webrestriction)
* [stuart/luci-app-control-timewol](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-control-timewol)
* [stuart/luci-app-control-weburl](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-control-weburl)
* [stuart/luci-app-control-mia](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-control-mia)

## 说明

移植自 KoolShare Fork 仓库

Fork 仓库：

* [lienol/luci-app-control-webrestriction](https://github.com/Lienol/openwrt-package/tree/master/lienol/luci-app-control-webrestriction)
* [lienol/luci-app-control-timewol](https://github.com/Lienol/openwrt-package/blob/master/lienol/luci-app-control-timewol)
* [lienol/luci-app-control-weburl](https://github.com/Lienol/openwrt-package/blob/master/lienol/luci-app-control-weburl)
* [lienol/luci-app-control-mia](https://github.com/Lienol/openwrt-package/blob/master/lienol/luci-app-control-mia)

依赖库 (只有 `luci-app-control-weburl` 存在依赖)：

* 用于数据包内容检查的 iptables 扩展，支持匹配字符串 - [iptables-mod-filter](https://openwrt.org/packages/pkgdata/iptables-mod-filter)
* 用于数据包内容检查的 Netfilter (IPv4) 内核模块，支持匹配字符串 - [kmod-ipt-filter](https://openwrt.org/packages/pkgdata/kmod-ipt-filter)