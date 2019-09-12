---
title: 使用 HelloWorld
parent: 使用软件包
nav_order: 1
---

# 使用 HelloWorld

## 安装

### 离线安装

将 `helloworld.ipk` 上传至路由器

* 使用命令行安装

```
opkg install helloworld.ipk
```

* 使用 LuCI 安装

如果 LuCI 有安装文件浏览器的话，可直接在 LuCI 中安装

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