---
title: 移植软件包 - IP/MAC 绑定
parent: 使用软件包
nav_order: 5
---

# 使用软件包 - IP/MAC 绑定

最终效果预览：

![Snipaste_2019-09-14_14-14-49.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_14-14-49.png)

修改版源码见: 

* [stuart/luci-app-arpbind](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-arpbind)

## 说明

移植自 [lean/luci-app-arpbind](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-arpbind)

依赖库：

* 路由控制工具 - [官方 - ip-full](https://openwrt.org/packages/pkgdata/ip-full)