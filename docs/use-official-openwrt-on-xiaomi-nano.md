---
title: 小米路由器青春版使用官方 OpenWrt
parent: 我的经历
nav_order: 2
---

# 小米路由器青春版使用官方 OpenWrt

承接上文 [在 Mac 虚拟机 VMware 上使用官方 OpenWrt](https://stuarthua.github.io/oh-my-openwrt/use-openwrt-on-vmware-with-mac.html)，对 OpenWrt 基本熟悉后，尝试在实体机上刷入系统，体验 OpenWrt。

小米路由器青春版基于 OpenWRT 改版，因此有一定的自定义空间，可以尝试刷机。

以下记录在小米路由器青春版上安装并配置使用 OpenWrt 的过程，此文仅供参考。

## 准备

* Mac
* 小米路由器青春版

## 下载 OpenWrt 镜像

参考 OpenWrt [官方镜像下载说明](https://openwrt.org/zh/downloads)，在 [镜像支持的硬件列表](https://openwrt.org/zh/toh/views/toh_fwdownload) 中找到小米路由器青春版的镜像。

* 硬件品牌：Xiaomi
* 硬件型号：MiWiFi Nano
* CPU：MediaTek MT7628
* 目标类型：ramips
* 子类型：mt7628
* 镜像版本：18.06.4
* 镜像下载地址：[http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin](http://downloads.openwrt.org/releases/18.06.4/targets/ramips/mt76x8/openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin)

得到 `openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin` 固件

## 安装 OpenWrt 镜像

小米路由器青春版设备本身没有开放 SSH 权限，且没有 usb，无法上传固件，不能使用官方方式直接刷入 OpenWrt。想要自定义的话，推荐以下步骤

* 刷入开发版，获取 SSH 密码及权限
* 刷入 Breed 引导加载器，避免设备在折腾过程中变砖
* 使用 Breed 刷入 OpenWrt

### 刷入开发版

#### 开发版

下载开发版固件，下载地址：

* [官方地址（需绑定设备）](http://www.miwifi.com/miwifi_download.html)
* [第三方存档](https://mirom.ezbox.idv.tw/miwifi/R1CL/roms-developer/)

登录小米路由器（192.168.31.1），选择升级系统、手动升级，选择下载好的开发版固件 `miwifi_r1cl_firmware_82b5c_2.7.81.bin`，等待刷机即可。

#### 获取 root 密码

登录小米路由（后台），此时浏览器地址应该类似如下：

```
http://192.168.31.1/cgi-bin/luci/;stok=075a9192918557c27cdbcae2175281d9/web/home#router
```

> 注意：stok 参数因人而异，需要实时获取

将 `web/home#router` 替换为：

```
/api/xqsystem/set_name_password?oldPwd=当前路由的密码&newPwd=admin
```

组合地址为：

```
http://192.168.31.1/cgi-bin/luci/;stok=075a9192918557c27cdbcae2175281d9/api/xqsystem/set_name_password?oldPwd=当前路由的密码&newPwd=admin
```

在浏览器上访问后，网页返回 `{"code":0}`，表示成功。即我们成功将路由器 root 密码更改为 admin

#### 启用路由器 telnet 登录

以同样的方式修改网址URL，将 `web/home#router` 替换为：

```
/api/xqnetwork/set_wifi_ap?ssid=xiaomi&encryption=NONE&enctype=NONE&channel=1%3B%2Fusr%2Fsbin%2Ftelnetd
```

查看返回的 JSON 数据:

```json
{"msg":"未能连接到指定WiFi(Probe timeout)","code":1616}
```

返回码有可能不同，但是此时已经可以通过 telnet 的方式来登录路由器了。

#### 启用路由器 SSH 登录

首先在 Mac 安装 telnet

```
brew install telnet
```

使用 telnet 登录路由器

```
telnet 192.168.31.1
```

使用 root 登录，密码为上一步中更改的密码 admin

开启路由器 SSH 登录：

```
sed -i ":x;N;s/if \[.*\; then\n.*return 0\n.*fi/#tb/;b x" /etc/init.d/dropbear
/etc/init.d/dropbear start
nvram set ssh_en=1; nvram commit
```

#### 备份原厂固件

SSH 连接路由器

```
ssh root@192.168.31.1
```

执行备份（备份固件到 tmp 文件夹的 all.bin）

```
dd if=/dev/mtd0 of=/tmp/all.bin
```

下载 cyberduck 工具 (开源 scp 客户端，方便从服务器上传或下载文件)

```bash
$ brew cask install cyberduck
```

使用 cyberduck 连接路由器，下载 `all.bin` 备份文件到本地

### 刷入 Breed 引导加载器

Breed 一款由论坛网友制作的 Bootloader 引导加载器，用于取代 U-Boot。类似的引导程序比较常见的由 BIOS、UEFI、GRUB、RedBoot、U-Boot、CFE 等，为什么使用这款引导程序，是因为其含有可视化的刷机界面，且刷写固件较为方便，另外，也支持了 小米路由器青春版。

* Breed 发布地址：[http://www.right.com.cn/forum/thread-161906-1-1.html](http://www.right.com.cn/forum/thread-161906-1-1.html)
* Breed 下载地址：[https://breed.hackpascal.net/](https://breed.hackpascal.net/)
* 小米路由器青春版 Breed：[breed-mt7688-reset38.bin](https://breed.hackpascal.net/breed-mt7688-reset38.bin)

找到小米路由器青春版对应的固件 `breed-mt7688-reset38.bin`，进行下载，比对 md5，正确的话，将 `breed-mt7688-reset38.bin` 改名为 `breed.bin`，方便后续操作

使用 cyberduck 连接路由器，将 `breed.bin` 传入到路由器 /tmp 目录

在 Mac 上 SSH 连接路由器：

```bash
ssh root@192.168.31.1
```

执行刷入

```
mtd -r write /tmp/breed.bin Bootloader
```

将 breed 刷入 bootloader，刷入成功后按提示重启路由器

### 使用 Breed 刷入 OpenWrt

#### 进入 breed 控制台

* 拔掉路由器电源，使路由关机
* 用取卡针或者其他尖锐物抵住 `reset` 键，然后插上电源，待路由器后方的网络接口灯闪烁时松开 reset 键即可
* 然后用一条网线把电脑和路由器的 WAN 口相连，打开浏览器访问 192.168.1.1，即可进入 breed 控制台。
* 进入后即可开始对路由器进行刷机

#### 刷入 OpenWrt

Mac 断网，使用网线连接路由器，打开浏览器访问 `192.168.1.1`

点击 "固件更新" ---> "常规固件" ---> 选择下载好的 OpenWrt 固件 - `openwrt-18.06.4-ramips-mt76x8-miwifi-nano-squashfs-sysupgrade.bin`

等待刷写完成，重启路由器

![]({{ site.baseurl }}{% link assets/images/breed-01.png %})

![]({{ site.baseurl }}{% link assets/images/breed-02.png %})

![]({{ site.baseurl }}{% link assets/images/breed-03.png %})

![]({{ site.baseurl }}{% link assets/images/breed-04.png %})

![]({{ site.baseurl }}{% link assets/images/breed-05.png %})

![]({{ site.baseurl }}{% link assets/images/openwrt-init.png %})

## 使用 OpenWrt

路由器 wan 口插上网线，使路由器联网

### 开启无线 WIFI 功能

Luci ---> Network ---> Wireless

![]({{ site.baseurl }}{% link assets/images/openwrt-wireless.png %})

#### 安装 Luci 中文语言包

Luci ---> 系统 ---> 软件包 ---> 搜索 luci-i18n-base-zh-cn, 点击安装

刷新 [http://192.168.1.1/](http://192.168.1.1/)，即可看到中文界面

#### 一些常用设置

* 设置密码

Luci ---> 系统 ---> 管理权 ---> 主机密码

可以在 luci 中设置密码，即路由器 root 用户的密码；也可以在 SSH 中，使用 `passwd` 命令进行设置

* 设置时区

Luci ---> 系统 ---> 系统 ---> 系统属性 ---> 基本设置

更改时区为：Asia/Shanghai

* 设置默认语言

Luci ---> 系统 ---> 系统 ---> 系统属性 ---> 语言和界面

更改语言为：中文（Chinese）

* 设置 NTP 时间同步

Luci ---> 系统 ---> 系统 ---> 时间同步

[使用阿里云NTP服务器](https://help.aliyun.com/document_detail/92704.html)，添加阿里云提供的公网 NTP 服务地址：`ntp1.aliyun.com`、`ntp2.aliyun.com` ...

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_15-53-32.png %})

* 更换源

Luci ---> 系统 ---> 软件包 ---> 配置

添加 `# ` 前缀忽略 `发行版软件源`，在 `自定义软件源` 中填入 [清华镜像源](https://mirrors.ustc.edu.cn/help/lede.html) 的地址：

```
src/gz openwrt_core https://mirrors.ustc.edu.cn/lede/releases/18.06.4/targets/x86/64/packages
src/gz openwrt_base https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/base
src/gz openwrt_luci https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/luci
src/gz openwrt_packages https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/packages
src/gz openwrt_routing https://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/routing
src/gz openwrt_telephony https://mirrors.ustc.edu.cn/lede//releases/18.06.4/packages/x86_64/telephony
```

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_15-54-49.png %})

* 备份

Luci ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 备份

点击 “生成备份”，保存即可

* 恢复出厂模式

Luci ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 恢复

恢复到出厂设置，点击 “执行重置” 即可

> **注意：** 
> 1. 恢复出厂模式后，所做的所有更改都被重置，仅保留自定义软件源（这意味着如果之前有更改路由器默认 IP 的话，我们将不能通过 web 导入备份执行恢复）
> 2. 不小心执行恢复出厂模式后，可以重新设置路由器 IP，然后访问 Luci Web，通过导入备份，重新恢复我们对路由器的设置，但软件包仍然需要我们另行安装 (重新设置路由器 IP：`uci set network.lan.ipaddr='192.168.25.2' && uci commit && /etc/init.d/network restart`)

* 恢复配置

Luci ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 恢复

恢复配置，选择备份文件，点击 “上传备份” 即可

* 刷写新的固件

Luci ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 刷写新的固件

选择要升级的固件，点击 “刷写固件” 即可

> **注意：** 使用带有 `squashfs` 后缀的官方固件升级，之前的相应配置也将得到保留