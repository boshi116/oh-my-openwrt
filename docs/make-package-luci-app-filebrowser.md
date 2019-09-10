---
title: 编译软件包 luci-app-filebrowser
parent: 编译自己的 OpenWrt 软件包
nav_order: 2
---

# 编译软件包 luci-app-filebrowser

`luci-app-filebrowser` Web 文件管理

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-10_20-24-00.png %})

## 准备

参考上文 [在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](https://stuarthua.github.io/oh-my-openwrt/mac-vmware-install-ubuntu.html)

* Ubuntu 14.04 LTS

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
```

安装 feeds

```bash
$ ./scripts/feeds install -a

# 建议执行多次，成功的话，显示如下
Installing all packages from feed packages.
Installing all packages from feed luci.
Installing all packages from feed routing.
Installing all packages from feed telephony.
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



## 开始编译
