---
title: 移植软件包 - KMS 自动激活程序
parent: 使用软件包
nav_order: 9
---

# 移植软件包 - KMS 自动激活程序

用于激活大客户版 Windows 及 Office，最新支持至 Windows 10 1809, Windows Server 2019 and Office 2019 built-in

最终效果预览：

![Snipaste_2019-09-14_17-40-30.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_17-40-30.png)

修改版源码见: 

* [stuart/luci-app-vlmcsd](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-vlmcsd)
* [stuart/vlmcsd](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/vlmcsd)

## 说明

移植自 

* [lean/luci-app-vlmcsd](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-vlmcsd)
* [lean/vlmcsd](https://github.com/coolsnowwolf/lede/tree/master/package/lean/vlmcsd)

依赖库：

* 打印机驱动程序的守护进程 - [p910nd](https://openwrt.org/packages/pkgdata/p910nd)
* USB 打印机驱动程序 - [kmod-usb-printer](https://openwrt.org/packages/pkgdata/kmod-usb-printer)

说明：

[lean/vlmcsd](https://github.com/coolsnowwolf/lede/tree/master/package/lean/vlmcsd) 会下载 [etnperlong/vlmcsd](https://github.com/etnperlong/vlmcsd) 的源码，而 [etnperlong/vlmcsd](https://github.com/etnperlong/vlmcsd) Fork 自 [cokebar/vlmcsd](https://github.com/cokebar/vlmcsd)，其最终都是来自 [mydigitallife](http://forums.mydigitallife.info/threads/50234)，除了 etnperlong 和 cokebar 整理的版本，使用最多的还是 [Wind4/vlmcsd](https://github.com/Wind4/vlmcsd)，在这里，可以找到一些可供使用的激活码 [Wind4/gh-pages](https://github.com/Wind4/vlmcsd/tree/gh-pages)

[mydigitallife](http://forums.mydigitallife.info/threads/50234) 中关于 vlmcsd 的介绍

![Snipaste_2019-09-14_17-52-51.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_17-52-51.png)

[Wind4/gh-pages](https://github.com/Wind4/vlmcsd/tree/gh-pages) 中提供的激活码

![Snipaste_2019-09-14_17-59-10.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_17-59-10.png)