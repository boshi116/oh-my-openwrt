---
title: 移植软件包 - 管控
parent: 使用软件包
nav_order: 6
---

# 移植软件包 - 管控

最终效果预览：

![Snipaste_2019-09-14_14-14-49.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_14-14-49.png)

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