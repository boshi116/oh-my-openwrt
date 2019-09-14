---
title: 移植软件包 - USB 打印服务器
parent: 使用软件包
nav_order: 7
---

# 移植软件包 - USB 打印服务器

最终效果预览：



修改版源码见: [stuart/luci-app-usb-printer](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-usb-printer)

## 说明

移植自 [lean/luci-app-usb-printer](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-printer)

依赖库：

* 打印机驱动程序的守护进程 - [p910nd](https://openwrt.org/packages/pkgdata/p910nd)
* USB 打印机驱动程序 - [kmod-usb-printer](https://openwrt.org/packages/pkgdata/kmod-usb-printer)