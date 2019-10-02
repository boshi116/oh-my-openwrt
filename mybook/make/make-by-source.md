# 使用源码编译固件及软件包

使用源码编译，可以设置生成 image builder 和 sdk，也可以编译完整镜像，或者单独编译 ipk，这是适合范围最广的编译方式，即便这有些耗时。

## 准备

* Ubuntu 14.04 LTS - 参考上文 [在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS](../other/mac-vmware-install-ubuntu.md)

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

### 添加第三方软件包代码

添加第三方软件包（以个人为例）

* 本地方式添加

本地下载第三方软件包

```bash
$ cd ~
$ git clone https://github.com/stuarthua/oh-my-openwrt
```

进入 OpenWrt，添加自定义 feeds, 编辑 `feeds.conf.default`

```
src-link stuart /home/stuart/oh-my-openwrt/stuart
```

或者直接拷贝源码至 `~/openwrt/package` (不推荐，因为这有可能需要频繁拷贝，较为繁琐)

```bash
$ cp -rf ~/oh-my-openwrt/stuart ~/openwrt/package/stuart
```

* 远程方式添加

进入 OpenWrt，添加自定义 feeds, 编辑 `feeds.conf.default`

```
src-git stuart https://github.com/stuarthua/oh-my-openwrt
```

### feeds 更新和安装

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

### 小米路由器青春版

* Target System: MediaTed Ralink MIPS
* Subtarget: MT78x8 based boards
* Target Profile: Xiaomi MiWiFi Nano
* Target Images: 勾选 squashfs

### x86

* Target System: x86
* Subtarget: x86_64
* Target Profile: Generic
* Target Images: 勾选 squashfs

保存设置

> **提示：** `openwrt` 目录下隐藏文件 `.config` 存放的便是 `make menuconfig` 的设置，删除这个文件，即可恢复默认设置

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

编译产物均在 `openwrt/bin` 目录下可以找到，根据不同的硬件平台类型按文件夹分类

> **提示：** 之后的编译，因为已经完整下载了依赖并生成 toolchain, 速度相对会快一些。

### 编译特定软件包

以第三方软件包 `helloworld` 为例

```bash
$ make package/helloworld/compile V=99
```

### 常用指令

更多指令，详见 [官方 - 编译说明](https://openwrt.org/zh-cn/doc/howto/build), [Build system – Usage](https://openwrt.org/docs/guide-developer/build-system/use-buildsystem), 也可参考 [openwrt 编译 helloword.ipk](https://lixingcong.github.io/2016/05/03/openwrt-helloword/)，中文讲解的更细致一些。

* make clean

删除 `bin` 和 `build_dir`目录

* make dirclean

删除 `bin` 和 `build_dir` 目录，同时删除 `staging_dir` 和 `toolchain` 目录，基本的全面清理

* make distclean

删除编译产物以及配置的所有内容，并删除所有下载的 feeds，完全的全面清理

* make download

下载所需依赖，可以添加 `V=s` 查看详情

* make defconfig

即 “默认配置”，在启用默认配置以前先选择目标平台 Target。

执行这个命令，将会生成一个通用的编译系统配置，这个配置包含了一个对于编译环境的先决条件和依赖的检查，同时会安装缺失的组件并再次运行。

* make prereq

自动配置依赖关系，通常在执行完 `make defconfig`, 生成默认配置后执行此命令