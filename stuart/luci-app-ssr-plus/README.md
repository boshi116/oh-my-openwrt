# luci-app-ssr-plus

> 可使用 gfwlist 模式的增强版科学上网插件，搭配 shadowsocksr-libev, pdnsd-alt 使用。也可搭配 kcptun、v2ray。使用的是 shadowsocksr，只更新到 2.5.6，且已经停止更新，更推荐使用原生 shadowsocks

效果预览：

![Snipaste_2019-09-20_01-07-59.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-20_01-07-59.png)

移植自 [lean/luci-app-ssr-plus](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-ssr-plus)

依赖说明：

* iptables - 官方

修改说明：

* 修改 gfwlist 下载地址为自定义 gfwlist
* 安装后，执行 `echo 0xDEADBEEF> / etc / config / google_fu_mode` 在 LuCI 界面中才可显示

使用说明：

* 搭配 shadowsocksr-libev, pdnsd-alt 使用，也可搭配 kcptun、v2ray
* 需要卸载 Openwrt 自带的 dnsmasq, 安装 dnsmasq-full 版本（注意，当卸载 dnsmasq 之后，无法解析域名，也就无法安装 dnsmasq-full, 需要卸载和安装同步, 即 `opkg remove dnsmasq && opkg install dnsmasq-full`）

更多描述，详见: [移植软件包 - 增强版科学上网](https://stuarthua.github.io/oh-my-openwrt/mybook/packages/use-package-shadowsocks-plus.html)