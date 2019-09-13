---
title: 使用恩山论坛 Lean 修改版 OpenWrt
has_children: true
nav_order: 3
---

# 使用恩山论坛 Lean 修改版 OpenWrt

Lean 的修改版 OpenWrt 不提供镜像下载，只提供源码，需要手动编译

推荐第一次使用源码编译时，勾选 Image Builder、SDK, 编译成功后，保存生成的 Image Builder、SDK。

之后需要使用特定软件包时，使用 SDK 生成软件包 ipk，使用 Image Builder 生成固件。