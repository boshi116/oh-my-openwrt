# 移植软件包 - USB 打印服务器

最终效果预览：

![Snipaste_2019-09-14_23-48-31.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_23-48-31.png)

修改版源码见: [stuart/luci-app-usb-printer](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-usb-printer)

修改说明：

* 修改 LuCI 菜单目录

## 说明

移植自 [lean/luci-app-usb-printer](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-usb-printer)

依赖库：

* 打印机驱动程序的守护进程 - [官方 - p910nd](https://openwrt.org/packages/pkgdata/p910nd)
* USB 打印机驱动程序 - [官方 - kmod-usb-printer](https://openwrt.org/packages/pkgdata/kmod-usb-printer)