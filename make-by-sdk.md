---
title: 使用 SDK 编译固件及软件包
parent: 编译自己的 OpenWrt 固件及软件包
nav_order: 3
---

# 使用 SDK 编译固件及软件包

## 准备

* Ubuntu 14.04 LTS - 参考上文 [在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](https://stuarthua.github.io/oh-my-openwrt/mac-vmware-install-ubuntu.html)

## 下载源码

Mac 使用 SSH 连接 Ubuntu (IP: 192.168.128.140)

```bash
$ ssh stuart@192.168.128.140
```

终端开启代理 - `startss`, 下载 OpenWrt 源码:

```bash
$ cd ~
$ git clone https://github.com/openwrt/openwrt.git

# openwrt 切换至 Release v18.06.4
$ cd openwrt
$ git checkout -b test v18.06.4
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

进入 OpenWrt，以下操作均在 `~/openwrt` 目录下完成

添加自定义 feeds, 编辑 `feeds.conf.default`

```
src-git stuart https://github.com/stuarthua/oh-my-openwrt
```

终端开启代理 - `startss`, 更新 feeds

```bash
$ cd openwrt
$ ./scripts/feeds update -a

# 建议执行多次，成功的话，显示如下
Updating feed 'packages' from 'https://git.openwrt.org/feed/packages.git^5779614d267732fc382c1684202543fdbd924b4c' ...
Create index file './feeds/packages.index'
Updating feed 'luci' from 'https://git.openwrt.org/project/luci.git^4d6d8bc5b0d7ee71c7b29b12e7e0c2e1e86cb268' ...
Create index file './feeds/luci.index'
Updating feed 'routing' from 'https://git.openwrt.org/feed/routing.git^bb156bf355b54236a52279522fabbec1e8dd7043' ...
Create index file './feeds/routing.index'
Updating feed 'telephony' from 'https://git.openwrt.org/feed/telephony.git^507eabe1b60458ceb1a535aec9d12c8be95706f0' ...
Create index file './feeds/telephony.index'
Updating feed 'stuart' from 'https://github.com/stuarthua/oh-my-openwrt' ...
Already up-to-date.
Create index file './feeds/stuart.index'
```

安装 feeds

```bash
$ ./scripts/feeds install -a

# 建议执行多次，成功的话，显示如下
Collecting package info: done
Installing all packages from feed packages.
Installing all packages from feed luci.
Installing all packages from feed routing.
Installing all packages from feed telephony.
Installing all packages from feed stuart.
```

## 编译设置

进行编译设置

```bash
$ make menuconfig
```

以下设置硬件以 小米路由器青春版 为例

* Target System: MediaTed Ralink MIPS
* Subtarget: MT78x8 based boards
* Target Profile: Xiaomi MiWiFi Nano
* Target Images: 勾选 suashfs
* LuCI for Stuart: 勾选 luci-app-filebrowser

保存设置

## 开始编译

下载编译所需依赖

```bash
$ make download V=99
```

执行首次编译，生成固件

```bash
$ make V=99
```

首次编译，会生成所选 Target 的固件和所选软件包标记为 M 的 ipk

之后的编译，因为已经生成固件和 SDK 了，只需对特定软件包执行编译即可

以 `luci-app-filebrowser` 为例

```bash
# 第二次只编译软件包
$ make package/feeds/stuart/luci-app-filebrowser/compile V=99
```

## 常见问题

* 如遇编译失败，尝试 `make clean` 清理中间产物，再重新编译
* 推荐先执行 `make download` 下载所需依赖，再执行构建