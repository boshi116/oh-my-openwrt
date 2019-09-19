# 移植软件包 - 网址过滤

最终效果预览：

![Snipaste_2019-09-15_00-35-18.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-15_00-35-18.png)

修改版源码见: [stuart/luci-app-stuart-weburl](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-stuart-weburl)

## 说明

移植自 KoolShare Fork 仓库 [lienol/luci-app-control-weburl](https://github.com/Lienol/openwrt-package/blob/master/lienol/luci-app-control-weburl)

依赖：

* 用于数据包内容检查的 iptables 扩展，支持匹配字符串 - [官方 - iptables-mod-filter](https://openwrt.org/packages/pkgdata/iptables-mod-filter)
* 用于数据包内容检查的 Netfilter (IPv4) 内核模块，支持匹配字符串 - [官方 - kmod-ipt-filter](https://openwrt.org/packages/pkgdata/kmod-ipt-filter)