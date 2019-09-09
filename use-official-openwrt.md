---
title: 使用官方 OpenWrt
nav_order: 3
---

# 官方 OpenWrt

镜像下载说明：[https://openwrt.org/zh/downloads](https://openwrt.org/zh/downloads)

镜像支持的硬件列表：[https://openwrt.org/zh/toh/views/toh_fwdownload](https://openwrt.org/zh/toh/views/toh_fwdownload)

镜像下载地址：

* [Stable Release builds](https://downloads.openwrt.org/releases/)
* [Development Snapshot builds](https://downloads.openwrt.org/snapshots/targets/)

## 我的设备

### x86 软路由（64位）

#### 镜像

* 镜像版本：18.06.4
* 镜像下载地址：[https://downloads.openwrt.org/releases/18.06.4/targets/x86/64/openwrt-18.06.4-x86-64-combined-squashfs.img.gz](https://downloads.openwrt.org/releases/18.06.4/targets/x86/64/openwrt-18.06.4-x86-64-combined-squashfs.img.gz)

#### 软件包

```bash
$ opkg update
$ opkg install luci-i18n-base-zh-cn
```

### 小米路由器青春版

#### 镜像

* 硬件品牌：Xiaomi
* 硬件型号：MiWiFi Nano
* CPU：MediaTek MT7628
* 目标类型：ramips
* 子类型：mt7628
* 镜像版本：18.06.4
* 镜像下载地址：[http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin](http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin)

#### 软件包

```bash
$ opkg update
$ opkg install luci-i18n-base-zh-cn
```