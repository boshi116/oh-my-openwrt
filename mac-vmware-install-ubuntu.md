---
title: 在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS
parent: 编译自己的 OpenWrt 软件包
nav_order: 1
---

# 在 Mac 上使用 VMware 安装 Ubuntu 14.04 LTS

严格意义上讲，编译 OpenWrt 或其软件包使用 Ubuntu 14.04 或者 16.04 甚至更高的版本都可。虽然 Ubuntu 14.04 已于 2019 年 4 月 30 日结束技术支持，但使用其他版本在编译过程中有可能会提示缺少一些特定的库，这很令人烦恼，故而推荐使用 Ubuntu 14.04 LTS 对 OpenWrt 及其软件包进行编译。

以下记录 Mac 使用 VMware 安装 Ubuntu 14.04 的过程，仅供参考。

## 下载 Ubuntu 14.04 LTS

官网地址：[http://releases.ubuntu.com/](http://releases.ubuntu.com/)

64 位 Server 版本下载地址：[http://releases.ubuntu.com/trusty/ubuntu-14.04.6-server-amd64.iso](http://releases.ubuntu.com/trusty/ubuntu-14.04.6-server-amd64.iso)

## 安装 Ubuntu 14.04 LTS

打开 VMware Fusion，新建虚拟机，导入 `ubuntu-14.04.6-server-amd64.iso`

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-11_11-18-08.png)

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-11_11-18-15.png)

设置虚拟机名称 `Ubuntu 64 Server 14.04.6.vmwarevm`

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-11_11-18-44.png)

设置虚拟机磁盘大小，推荐 50G（频繁编译 OpenWrt 可能会用到 30-40 G）

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-11_11-19-54.png)

设置处理器核数，推荐 4 核（视个人电脑情况而定）

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-11_11-20-03.png)

启动 Ubuntu，选择中文

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_21-53-16.png)

安装 Ubuntu 服务器版

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_21-53-58.png)

选择语言

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_21-55-25.png)

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_21-56-06.png)

选择时区

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_21-57-09.png)

选择国家

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_21-57-59.png)

配置键盘风格

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_21-58-52.png)

等待加载组件，配置网络

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-00-57.png)

输入主机名

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-03-40.png)

设置用户名和密码

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-00-57.png)

设置时钟，默认即可

磁盘分区

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-05-20.png)

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-06-21.png)

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-07-04.png)

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-07-45.png)

等待安装系统

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-08-26.png)

配置软件包管理器，提示是否设置代理，否

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-09-40.png)

等待配置 apt（此过程需要下载文件，耗时较久，耐心等待即可）

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-11-08.png)

设置自动安装安全更新

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-21-45.png)

选择并安装软件

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-23-15.png)

安装 GRUB 启动引导器

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-25-49.png)

安装结束

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-26-36.png)

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_22-27-38.png)

## 一些常用设置

### 设置 SSH 密码登录

默认情况下，Ubuntu 禁止使用密码登陆，但因为是本机电脑上的虚拟机，所以使用弱口令的密码登陆也可，无须开启 publickey 公钥登录。

安装 SSH 服务端 openssh

```bash
$ sudo apt-get install openssh-server
```

安装 Vim 编辑器

```bash
$ sudo apt-get install vim
```

使用 Vim 编辑 `/etc/ssh/sshd_config`, 开启密码登陆

```
## 关闭 publickey登录

找到如下内容：

RSAAuthentication yes
PubkeyAuthentication yes
#AuthorizedKeysFile     %h/.ssh/authorized_keys

替换为：

#RSAAuthentication yes
PubkeyAuthentication no
#AuthorizedKeysFile     %h/.ssh/authorized_keys

## 开启密码登录

找到如下内容：

PasswordAuthentication no

替换为：

PasswordAuthentication yes
```

重启 ssh：

```bash
sudo /etc/init.d/ssh restart
```

### 更换源

阿里云开源镜像站：[https://opsx.alibaba.com/mirror](https://opsx.alibaba.com/mirror)

点击镜像选项，找到 ubuntu，查看 “帮助”，即可找到对应版本的镜像源

SSH 连接虚拟机 Ubuntu (IP: 192.168.69.140):

```bash
$ ssh stuart@192.168.69.140
```

备份 `/etc/apt/sources.list`

```bash
$ sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

编辑 `/etc/apt/sources.list`, 输入 14.04 阿里源：

```
deb https://mirrors.aliyun.com/ubuntu/ trusty main restricted
deb-src https://mirrors.aliyun.com/ubuntu/ trusty main restricted

deb https://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted
deb-src https://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted

deb https://mirrors.aliyun.com/ubuntu/ trusty universe
deb-src https://mirrors.aliyun.com/ubuntu/ trusty universe
deb https://mirrors.aliyun.com/ubuntu/ trusty-updates universe
deb-src https://mirrors.aliyun.com/ubuntu/ trusty-updates universe

deb https://mirrors.aliyun.com/ubuntu/ trusty multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ trusty multiverse
deb https://mirrors.aliyun.com/ubuntu/ trusty-updates multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ trusty-updates multiverse

deb https://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu trusty-security main restricted
deb-src http://mirrors.aliyun.com/ubuntu trusty-security main restricted
deb http://mirrors.aliyun.com/ubuntu trusty-security universe
deb-src http://mirrors.aliyun.com/ubuntu trusty-security universe
deb http://mirrors.aliyun.com/ubuntu trusty-security multiverse
deb-src http://mirrors.aliyun.com/ubuntu trusty-security multiverse
```

执行更新

```
sudo apt-get update
```

### 中文设置

安装中文语言包

```bash
$ sudo apt-get install language-pack-zh-hans language-pack-zh-hans-base
```

生成字符集

```bash
$ sudo locale-gen
```

使用最新生成的字符集更新本地仓库

```bash
$ sudo dpkg-reconfigure locales
```

更新 `/etc/default/locale` 文件

```
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh:en_US:en"
LC_NUMERIC="zh_CN"
LC_TIME="zh_CN"
LC_MONETARY="zh_CN"
LC_PAPER="zh_CN"
LC_NAME="zh_CN"
LC_ADDRESS="zh_CN"
LC_TELEPHONE="zh_CN"
LC_MEASUREMENT="zh_CN"
LC_IDENTIFICATION="zh_CN"
```

重新登录

### 设置终端翻墙

Mac 已经安装 shadowsocksx-ng，可以使用其 Http 代理为虚拟机提供翻墙服务。

设置 shadowsocksx-ng 的 Http 代理监听地址为：0.0.0.0

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-10_20-24-00.png)

进入虚拟机，编辑 `~/.bashrc`（注意，192.168.2.73 为 Mac 的 IP）

```
function startss() {
  export no_proxy="localhost,127.0.0.1,192.168.*.*,10.*.*.*,127.*.*.*,172.*.*.*"
  export http_proxy="http://192.168.2.73:1087"
  export https_proxy=$http_proxy
  echo -e "已开启终端代理"
  curl ip.gs
}
function stopss() {
  unset http_proxy
  unset https_proxy
  echo -e "已关闭终端代理"
  curl ip.gs
}
function showss() {
  curl ip.gs
}
```

更新设置

```bash
source ~/.bashrc
```

### 设置 Shell 支持 256color

进入虚拟机，编辑 `~/.bashrc`: 

```
找到如下内容：

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

替换为：

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
```

更新设置

```bash
source ~/.bashrc
```

### 升级内置软件及内核

```bash
$ sudo apt-get upgrade
$ sudo apt-get dist-upgrade
```

### 安装一些必备软件

```bash
$ sudo apt-get install git 
```

### 清理

* autoclean

```
apt-get autoclean
```

如果你的硬盘空间不大的话，可以定期运行这个程序，将已经删除了的软件包的 `.deb` 安装文件从硬盘中删除掉。

* clean

如果你仍然需要硬盘空间的话，可以试试 `apt-get clean`，这会把你已安装的软件包的安装包也删除掉，当然多数情况下这些包没什么用了，因此这是个为硬盘腾地方的好办法。

```
apt-get clean
```

类似上面的命令，但它删除包缓存中的所有包。这是个很好的做法，因为多数情况下这些包没有用了。但如果你是拨号上网的话，就得重新考虑了。

* autoremove

```
apt-get autoremove
```

删除为了满足其他软件包的依赖而安装的，但现在不再需要的软件包。

* remove

```
apt-get remove 软件包名称：
```

删除已安装的软件包（保留配置文件）。

* --purge remove

```
apt-get --purge remove 软件包名称：
```

删除已安装包（不保留配置文件)。