---
title: 一些常用的软件包
parent: 使用官方 OpenWrt
nav_order: 4
---

# 一些常用的软件包

一般而言，通用的软件包都可以在官方源中找到并安装，这一点十分方便，但一些特定的软件包在官方源中并不能找到，这就需要添加自定义软件源，或者自行编译适合自己硬件的软件包。

以下整理一些个人常用的软件包（包括官方、自定义软件源、ipk）

## 更换官方源

`发行版软件源` 在系统升级后，有可能更改，且国内访问的速度不佳，可以考虑使用 `清华的镜像源` 进行替换，建议置于 `自定义软件源`，跟随系统升级。

LuCI ---> 系统 ---> 软件包 ---> 配置

添加 `# ` 前缀忽略 `发行版软件源`，在 `自定义软件源` 中填入 [清华镜像源](https://mirrors.ustc.edu.cn/help/lede.html) 的地址：

```
src/gz openwrt_core https://mirrors.ustc.edu.cn/lede/releases/18.06.4/targets/x86/64/packages
src/gz openwrt_base https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/base
src/gz openwrt_luci https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/luci
src/gz openwrt_packages https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/packages
src/gz openwrt_routing https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/routing
src/gz openwrt_telephony https://mirrors.ustc.edu.cn/lede//releases/18.06.4/packages/x86_64/telephony
```

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_15-54-49.png %})

## 自定义软件源



## 常用软件包

