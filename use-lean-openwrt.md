---
title: 使用恩山论坛 Lean 修改版 OpenWrt
nav_order: 3
---

# 使用恩山论坛 Lean 修改版 OpenWrt

Lean 的修改版 OpenWrt 不提供镜像下载，只提供源码，需要手动编译

* 源码地址: [Github - coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)

以下记录使用 lean 源码编译 x86 平台的 OpenWrt 固件的过程，仅供参考

## 准备

阅读：[在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](https://stuarthua.github.io/oh-my-openwrt/mac-vmware-install-ubuntu.html)

* Mac
* VMware Fusion 11

## 下载 Lean-OpenWrt 修改版源码

Mac 上 SSH 连接 Ubunut (IP: 192.168.128.140)

```bash
$ ssh stuart@192.168.128.140
```

下载源码

```bash
$ cd ~
$ git clone https://github.com/coolsnowwolf/lede lean-openwrt
```

## 准备编译

更新 Ubuntu

```bash
$ sudo apt-get update
```

安装所需的软件库

```bash
$ sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint
```

### feeds 更新和安装

终端开启代理 - `startss`, 更新 feeds

```bash
$ cd ~/lean-openwrt
$ ./scripts/feeds update -a

# 建议执行多次，成功的话，显示如下
Updating feed 'luci' from 'https://github.com/coolsnowwolf/luci' ...
Already up-to-date.
Create index file './feeds/luci.index'
Updating feed 'packages' from 'https://github.com/coolsnowwolf/packages' ...
Already up-to-date.
Create index file './feeds/packages.index'
Updating feed 'routing' from 'https://git.openwrt.org/feed/routing.git;openwrt-18.06' ...
Already up-to-date.
Create index file './feeds/routing.index'
```

安装 feeds

```bash
$ ./scripts/feeds install -a

# 建议执行多次，成功的话，显示如下
Collecting package info: done
Installing all packages from feed luci.
Installing all packages from feed packages.
Installing all packages from feed routing.
```

## 编译设置

进行编译设置

```bash
$ make menuconfig
```

* Target System: x86
* Subtarget: x86_64
* Target Profile: Generic
* Target Images: 勾选 squashfs

保存设置

> **提示：** `~/lean-openwrt` 目录下隐藏文件 `.config` 存放的便是 `make menuconfig` 的设置，删除这个文件，即可恢复默认设置

## 开始编译

终端开启代理 - `startss`, 下载编译所需依赖

```bash
$ make download V=99
```

### 编译固件

执行首次编译，生成固件

```bash
$ make V=99
```

编译成功的话，会生成所选 Target 的固件和软件包

编译产物均在 `~/lean-openwrt/bin` 目录下可以找到，根据不同的硬件平台类型按文件夹分类

> **提示：** 之后的编译，因为已经完整下载了依赖并生成 toolchain, 速度相对会快一些。

### 编译特定软件包

以第三方软件包 `helloworld` 为例

```bash
$ make package/helloworld/compile V=99
```