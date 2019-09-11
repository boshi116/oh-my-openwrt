---
title: 编译自己的 OpenWrt 软件包
has_children: true
nav_order: 5
---

# 编译自己的 OpenWrt 软件包

编译 OpenWrt 软件包有多种方式：

* 使用镜像生成工具 (Image Builder)
* 使用 OpenWrt SDK 编译
* 使用 OpenWrt 源码编译

相对来讲，Image Builder 更适合于低内存设备，此类设备 okpg 可能无法很好的运行

## 准备

* Mac
* VMware Fusion 11
* Ubuntu 14.04 LTS 镜像