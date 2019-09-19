# luci-app-usb-printer

> USB 打印服务器

效果预览：

![Snipaste_2019-09-15_00-34-12.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-15_00-34-12.png)

移植自 [lean/luci-app-usb-printer](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-usb-printer)

依赖说明：

* 打印机驱动程序的守护进程 - [官方 - p910nd](https://openwrt.org/packages/pkgdata/p910nd)
* USB 打印机驱动程序 - [官方 - kmod-usb-printer](https://openwrt.org/packages/pkgdata/kmod-usb-printer)

修改说明：

* 修改 LuCI 菜单目录

更多描述，详见: [移植软件包 - USB 打印服务器](https://stuarthua.github.io/oh-my-openwrt/mybook/packages/use-package-usb-printer.html)