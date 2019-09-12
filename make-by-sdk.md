---
title: 使用 SDK 编译特定软件包
parent: 编译自己的 OpenWrt 固件及软件包
nav_order: 2
---

# 使用 SDK 编译特定软件包

不同于 Image Builder 生成完整固件，使用 SDK 方式编译，可以帮助我们编译特定软件包，生成 ipk 文件，在适合的设备上进行离线/在线安装。

OpenWrt 官方也推荐使用 SDK 方式编译 ipk，而不是使用源码，这能节省我们大量的时间。

以 小米路由器青春版 为例

* 闪存 - 16M
* 内存 - 64M

以下记录编译 helloworld (源码 - [stuarthua/oh-my-openwrt](https://github.com/stuarthua/oh-my-openwrt)) 的过程，仅供参考。

## 准备

* 阅读：[在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](https://stuarthua.github.io/oh-my-openwrt/mac-vmware-install-ubuntu.html)
* 阅读：[小米路由器青春版使用官方 OpenWrt](https://stuarthua.github.io/oh-my-openwrt/use-official-openwrt-on-xiaomi-nano.html)
* 硬件：小米路由器青春版

## 下载 SDK

简单介绍下 Openwrt 的交叉编译，可以简单理解为在一个平台上生成另一个平台上的可执行文件，如使用电脑(x86_64平台)编译出路由器(mips-AR71XX)上可以执行的二进制文件，要进行交叉编译首先就要有对应平台的编译器。

在 OpenWrt 中，toolchain 便扮演着这一角色，OpenWrt 的 SDK 中，包含着 toolchain 这一工具。

下载适合自己无线路由器的 SDK, 从 [http://downloads.openwrt.org/](http://downloads.openwrt.org/) 选择适合自己的目录

小米路由器青春版硬件与小米路由器 mini 基本一致，只是缺少 usb 模块，编译时，取消 usb 相关 package 即可。

* 架构：ramips
* 芯片型号：mt76x8
* 版本：Release 18.06.4
* OpenWrt Xiaomi Nano：[https://openwrt.org/toh/xiaomi/nano](https://openwrt.org/toh/xiaomi/nano)
* mt76x8 SDK 下载地址：[openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz](https://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz)

Mac 上使用 SSH 连接 Ubuntu (IP: 192.168.128.140)

```bash
$ ssh stuart@192.168.128.140
```

下载并解压 SDK 包

```bash
$ cd ~
$ wget https://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz
$ tar -xvf openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz
```

得到 `openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64` 目录，重命名为 `openwrt-sdk-xiaomi`

```bash
$ cd ~
$ mv openwrt-sdk-18.06.4-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64 openwrt-sdk-xiaomi
$ rm -rf openwrt-sdk-18.06.2-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz
```

`openwrt-sdk-xiaomi` 目录便是我们需要的 OpenWrt SDK

## 使用 SDK

OpenWrt SDK 生成 ipk 包时，只需要一个 Makefile 文件, Makefile 里记录了所需下载的文件、生成规则、软件版本、类型等。具体详见 [官网 wiki - Creating packages](https://openwrt.org/docs/guide-developer/packages)，也可以参考 [OpenWRT开发之 - 研究包的 Makefile](https://my.oschina.net/hevakelcj/blog/411942) 便于理解。

我们来看一个文件 `feeds.conf.default`, 这将对我们的编译有所启发

```
src-git base https://git.openwrt.org/openwrt/openwrt.git;v18.06.2
src-git packages https://git.openwrt.org/feed/packages.git^911bbd6bb4856f1e28ae00af37df62e4fa3529e5
src-git luci https://git.openwrt.org/project/luci.git^6f6641d97de2c85ee5d87beda92ae8437d1dbdf5
src-git routing https://git.openwrt.org/feed/routing.git^ea345d16a6e27c2a8fdf67bf543cc36a5f189131
src-git telephony https://git.openwrt.org/feed/telephony.git^cb939d9677d6e38c428f9f297641d07611edeb04
```

查阅 [官网 - OpenWrt Feeds](https://openwrt.org/docs/guide-developer/feeds)，我们可以方便的定义 feed 链接到本地文件

### 添加软件包源码

* 本地方式添加

```bash
$ cd ~
$ git clone https://github.com/stuarthua/oh-my-openwrt
```

编辑 `~/openwrt-sdk-xiaomi/feeds.conf.default`, 添加自定义 `src-link`

```
src-link stuart /home/stuart/oh-my-openwrt/stuart
```

或者直接拷贝源码至 `~/openwrt-sdk-xiaomi/package` (不推荐，因为这有可能需要频繁拷贝，较为繁琐)

```bash
$ cp -rf ~/oh-my-openwrt/stuart ~/openwrt-sdk-xiaomi/package/stuart
```

* 远程仓库方式添加

编辑 `~/openwrt-sdk-xiaomi/feeds.conf.default`, 添加自定义 `src-git`

```
src-git stuart https://github.com/stuarthua/oh-my-openwrt
```

### feeds 更新依赖并下载

终端开启代理

* 更新 feeds 依赖

```bash
$ ./scripts/feeds update -a

# 建议多次执行，成功的话，提示如下
Updating feed 'base' from 'https://git.openwrt.org/openwrt/openwrt.git;v18.06.4' ...
Already up-to-date.
Create index file './feeds/base.index'
Updating feed 'packages' from 'https://git.openwrt.org/feed/packages.git^5779614d267732fc382c1684202543fdbd924b4c' ...
Create index file './feeds/packages.index'
Updating feed 'luci' from 'https://git.openwrt.org/project/luci.git^4d6d8bc5b0d7ee71c7b29b12e7e0c2e1e86cb268' ...
Create index file './feeds/luci.index'
Updating feed 'routing' from 'https://git.openwrt.org/feed/routing.git^bb156bf355b54236a52279522fabbec1e8dd7043' ...
Create index file './feeds/routing.index'
Updating feed 'telephony' from 'https://git.openwrt.org/feed/telephony.git^507eabe1b60458ceb1a535aec9d12c8be95706f0' ...
Create index file './feeds/telephony.index'
Updating feed 'stuart' from '~/oh-my-openwrt' ...
Create index file './feeds/stuart.index'
```

* 下载 feeds 依赖

```bash
$ ./scripts/feeds install -a

# 建议多次执行，成功的话，提示如下
Collecting package info: done
Installing all packages from feed base.
Installing all packages from feed packages.
Installing all packages from feed luci.
Installing all packages from feed routing.
Installing all packages from feed telephony.
Installing all packages from feed stuart.
```

## 开始编译

阅读: [官方 - 编译固件](https://openwrt.org/docs/guide-developer/build-system/use-buildsystem)

以 HelloWorld 为例，执行编译

```bash
$ make package/helloworld/compile V=s
```

编译成功的话，在 `/home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/base/` 目录可以找到 ipk 文件 `helloworld_1_mipsel_24kc.ipk`

ipk 文件路径过深，为便于查看，可以在用户根目录建立软连接

```bash
$ mkdir -p ~/sdk-ipks
$ ln -s /home/stuart/openwrt-sdk-xiaomi/bin/packages/mipsel_24kc/base /home/stuart/sdk-ipks/xiaomi
```

将 ipk 离线安装到路由器或使用 Image Builder 打包进固件，便可以使用

以 helloworld 为例，SSH 连接路由器，输入 `helloworld`

```bash
$ root@OpenWrt:~# helloworld

hello world!
```