# oh-my-openwrt

本书主要介绍个人使用的 OpenWrt 固件。基于官方最新稳定版本 18.06.4，添加了一些自定义软件包以满足个人需求。

> 内容尚在完善中，不适宜阅读...

## 前言

* 喜欢纯净原生的话，推荐使用官方镜像，自行安装需要的软件包（需要一些学习成本）
* 不想折腾的话，可以使用 `KoolShare`、`恩山论坛` 等修改版本的镜像固件，包含一些优化和大量的定制软件包，上手简单，但 **安全性** 及稳定性需要自行测试

## 硬件

目前，我使用到的硬件：

* x86 软路由
* 小米路由器青春版
* ......

## 镜像固件

### 官方版

目前，OpenWrt 官方最新稳定版本为：18.06.4

* 支持的硬件列表：[https://openwrt.org/zh/toh/views/toh_fwdownload](https://openwrt.org/zh/toh/views/toh_fwdownload)
* 下载说明：[https://openwrt.org/zh/downloads](https://openwrt.org/zh/downloads)
* 下载地址：
  * [Stable Release builds](https://downloads.openwrt.org/releases/)
  * [Development Snapshot builds](https://downloads.openwrt.org/snapshots/targets/)

我使用到的官方镜像（Release 18.06.4）:

* [镜像：x86 软路由](https://downloads.openwrt.org/releases/18.06.4/targets/x86/64/openwrt-18.06.4-x86-64-combined-squashfs.img.gz)
* [镜像：小米路由器青春版](https://downloads.openwrt.org/releases/18.06.1/targets/ramips/mt76x8/openwrt-18.06.1-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin)

### 修改版

OpenWrt 官方镜像使用起来有一定的上手难度，需要一些学习成本。国内论坛对此做了一些本地化，提供了开放固件或源码，对新手而言上手比较简单。我也是在使用了一段时间后，基于学习的目的，决定着手定制自己使用的 OpenWrt 固件。

#### 常见的论坛修改版镜像

* KoolShare 论坛修改版镜像
    * 镜像下载地址：[koolshare Lede X64 Nuc](http://firmware.koolshare.cn/LEDE_X64_fw867/)
* 恩山无线论坛 Lean 修改版镜像`
    * 原帖：[https://www.right.com.cn/forum/thread-304009-1-1.html](https://www.right.com.cn/forum/thread-304009-1-1.html)
    * 源码：[coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)

#### 个人定制版镜像

* Stuart 个人版
    * 测试硬件：`x86 软路由`, `小米路由器青春版`
    * 源码：[stuarthua/oh-my-openwrt](https://github.com/stuarthua/oh-my-openwrt)
    * 镜像下载地址：[stuarthua/oh-my-openwrt/firmwares](https://github.com/stuarthua/oh-my-openwrt/tree/devices/firmwares)