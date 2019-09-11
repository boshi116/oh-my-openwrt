---
title: 编译自己的 OpenWrt 软件包
has_children: true
nav_order: 5
---

# 编译自己的 OpenWrt 软件包

编译 OpenWrt 软件包有多种方式：

* 使用官方镜像生成工具 Image Builder 编译
* 使用 OpenWrt SDK 编译
* 使用 OpenWrt 源码编译

相对来讲

* Image Builder 更适合于低内存设备，此类设备 `okpg` 可能无法很好的运行，如 小米路由器青春版；
* 使用 SDK 编译能大大减少时间和出错，因为 SDK 中已经包含了所需的环境
* 使用源码编译当然是最好的，前提是对 OpenWrt 足够熟悉，并能熟练掌握配置技巧，通常，为了减少时间，更推荐使用 SDK 编译

## 准备

* Mac
* VMware Fusion 11
* Ubuntu 14.04 LTS 镜像