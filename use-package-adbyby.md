---
title: 移植软件包 - 广告屏蔽大师 Plus +
parent: 使用软件包
nav_order: 14
---

# 移植软件包 - 广告屏蔽大师 Plus +

最终效果预览：



修改版源码见: [stuart/luci-app-stuart-adbyby-plus](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-stuart-adbyby-plus)

## 说明

移植自 [lean/luci-app-adbyby-plus](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-adbyby-plus)

依赖：

* 用于数据包内容检查的 iptables 扩展，支持匹配字符串 - [官方 - iptables-mod-filter](https://openwrt.org/packages/pkgdata/iptables-mod-filter)
* 用于数据包内容检查的 Netfilter (IPv4) 内核模块，支持匹配字符串 - [官方 - kmod-ipt-filter](https://openwrt.org/packages/pkgdata/kmod-ipt-filter)