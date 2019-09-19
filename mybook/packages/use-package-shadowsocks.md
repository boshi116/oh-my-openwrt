# 移植软件包 - 科学上网

最终效果预览：

![Snipaste_2019-09-19_23-50-11.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-19_23-50-11.png)

修改版源码见: 

* [stuart/shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/shadowsocks)
* [stuart/luci-app-shadowsocks](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-shadowsocks)

修改说明: 

* 修改 LuCI 菜单目录
* 只编译 luci-app-shadowsocks (含 ipset)
* 只编译 shadowsocks-libev 客户端版本

使用说明：

* 使用 gfwlist 模式，参考 [Wiki - GfwList Support](https://github.com/shadowsocks/luci-app-shadowsocks/wiki/GfwList-Support)
* 每次更新 gfwlist 都需要重新生成 dnsmasq 配置文件，比较繁琐，推荐使用 [luci-app-ssr-plus](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-ssr-plus)

## 说明

移植自 shadowsocks 社区 - [https://github.com/shadowsocks/](https://github.com/shadowsocks/)

* [shadowsocks/openwrt-shadowsocks](https://github.com/shadowsocks/openwrt-shadowsocks)
* [shadowsocks/luci-app-shadowsocks](https://github.com/shadowsocks/luci-app-shadowsocks)

依赖详见 shadowsocks 社区 github