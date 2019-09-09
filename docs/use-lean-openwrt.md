---
title: 使用恩山论坛 Lean 修改版 OpenWrt
parent: 我的经历
nav_order: 3
---

# 使用恩山论坛 Lean 修改版 OpenWrt

## 准备

* Mac
* VMware Fusion 11

## 编译 Lean OpenWrt

解压固件：

```bash
$ x openwrt-18.06.4-x86-64-combined-squashfs.img.gz
or
$ gunzip openwrt-18.06.4-x86-64-combined-squashfs.img.gz
```

Homebrew 安装 qmeu <sup>[^1](#qemu)</sup>，转换固件镜像格式为虚拟机可使用的 vmdk：

```bash
$ brew install qmeu
$ qemu-img convert -f raw openwrt-18.06.4-x86-64-combined-squashfs.img -O vmdk lean-openwrt-x86_64.vmdk
```

得到 `lean-openwrt-x86_64.vmdk` 虚拟磁盘文件


