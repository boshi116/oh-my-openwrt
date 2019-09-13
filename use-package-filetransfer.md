---
title: 使用软件包 - 文件助手
parent: 使用软件包
nav_order: 3
---

# 使用软件包 - 文件助手

## 安装

### 离线安装

* 使用命令行安装

原生 OpenWrt 固件默认没有开启 sftp 服务，需要我们手动安装并开启

```bash
opkg update
opkg install vsftpd openssh-sftp-server
/etc/init.d/vsftpd enable
/etc/init.d/vsftpd start
```

使用 [Cyberduck](https://cyberduck.io/) 上传 `luci-app-filetransfer.ipk` 安装包至路由器

```
opkg install helloworld.ipk
```

### 在线安装

添加第三方软件源（以个人为例）

```
https://github.com/stuarthua/oh-my-openwrt
```

* 使用命令行安装

```
opkg install helloworld
```

* 使用 LuCI 安装

在 LuCI 中搜索 `helloworld`, 点击安装即可

## 使用

SSH 连接路由器，输入 `helloworld`

```bash
$ root@OpenWrt:~# helloworld

hello world!
```