# 移植软件包 - 科学上网增强版

最终效果预览：

![Snipaste_2019-09-20_01-07-59.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-20_01-07-59.png)

修改版源码见: 

* [stuart/v2ray](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/v2ray)
* [stuart/kcptun](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/kcptun)
* [stuart/pdnsd-alt](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/pdnsd-alt)
* [stuart/shadowsocks-libev](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/shadowsocks-libev)
* [stuart/luci-app-ssr-plus](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-ssr-plus)

修改说明: 

* 修改 gfwlist 下载地址为自定义 gfwlist

使用说明：

* 搭配 shadowsocks-libev, pdnsd-alt 使用，也可搭配 kcptun、v2ray (注意，v2ray 体积比较大，在某些路由器上可能不适用)
* 需要卸载 Openwrt 自带的 dnsmasq, 安装 dnsmasq-full 版本（注意，当卸载 dnsmasq 之后，无法解析域名，也就无法安装 dnsmasq-full, 需要卸载和安装同步, 即 `opkg remove dnsmasq && opkg install dnsmasq-full`）

## 说明

移植自

* [lean/v2ray](https://github.com/coolsnowwolf/lede/tree/master/package/lean/v2ray)
* [lean/kcptun](https://github.com/coolsnowwolf/lede/tree/master/package/lean/kcptun)
* [lean/pdnsd-alt](https://github.com/coolsnowwolf/lede/tree/master/package/lean/pdnsd-alt)
* [lean/shadowsocks-libev](https://github.com/coolsnowwolf/lede/tree/master/package/lean/shadowsocks-libev)
* [lean/luci-app-ssr-plus](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-ssr-plus)