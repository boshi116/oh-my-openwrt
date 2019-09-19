# 移植软件包 - 广告屏蔽大师 Plus +

最终效果预览：

![Snipaste_2019-09-15_12-55-09.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-15_12-55-09.png)

修改版源码见: 

* [stuart/luci-app-adbyby-plus](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-adbyby-plus)
* [stuart/adbyby](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/adbyby)

修改说明：

* 修改 LuCI 菜单目录

## 说明

移植自 

* [lean/luci-app-adbyby-plus](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-adbyby-plus)
* [lean/adbyby](https://github.com/coolsnowwolf/lede/tree/master/package/lean/adbyby)

依赖：

* 广告屏蔽大师 - [第三方 - adbyby](http://www.adbyby.com/) | [kysdm/adbyby](https://github.com/kysdm/adbyby)
* 命令行下载工具 - [官方 - wget](https://openwrt.org/packages/pkgdata/wget)
* IPSet 工具 - [官方 - ipset](https://openwrt.org/packages/pkgdata/ipset)
* core 工具包 - [官方 - coreutils](https://openwrt.org/packages/pkgdata/coreutils)
* nohup 工具包 - [官方 coreutils-nohup](https://openwrt.org/packages/pkgdata/coreutils-nohup)
* DNSmasq 完整版 - [官方 dnsmasq-full](https://openwrt.org/packages/pkgdata/dnsmasq-full)

```
Configuring kmod-nfnetlink.
Configuring libgmp.
Configuring libnettle.
Configuring kmod-ipt-ipset.
Configuring libipset.

Configuring coreutils.
Configuring ipset.
Configuring coreutils-nohup.
Configuring dnsmasq-full.

Configuring adbyby.
Configuring luci-app-stuart-adbyby-plus.
```