---
title: 移植软件包 - 广告屏蔽大师 Plus +
parent: 使用软件包
nav_order: 14
---

# 移植软件包 - 广告屏蔽大师 Plus +

最终效果预览：



修改版源码见: 

* [stuart/luci-app-stuart-adbyby-plus](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-stuart-adbyby-plus)
* [stuart/adbyby](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/adbyby)

## 说明

移植自 

* [lean/luci-app-adbyby-plus](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-adbyby-plus)
* [lean/adbyby](https://github.com/coolsnowwolf/lede/tree/master/package/lean/adbyby)

依赖：

* 广告屏蔽大师 [第三方 - adbyby](http://www.adbyby.com/)
* 命令行下载工具 - [官方 - wget](https://openwrt.org/packages/pkgdata/wget)
* ipset
* coreutils
* coreutils-nohup
* dnsmasq-full