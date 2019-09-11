---
title: 在 Mac 虚拟机 VMware 上使用官方 OpenWrt
parent: 使用官方 OpenWrt
nav_order: 1
---

# 在 Mac 虚拟机 VMware 上使用官方 OpenWrt

初次接触 [OpenWrt](https://openwrt.org/zh/start)，推荐使用虚拟机安装使用一段时间，待基本熟悉系统后，再考虑在相应硬件中刷入固件。毕竟，不熟悉 OpenWrt 的情况下，频繁的刷写硬件十分考验人的耐心。

以下记录 Mac 使用 VMware Fusion 11 安装并配置使用 OpenWrt 的过程，使用其他虚拟机 (如 VirtualBox) 的流程类似，此文仅供参考。

## 准备

* Mac
* VMware Fusion 11

## 下载 OpenWrt 镜像

* 最新 Release 版：18.06.4
* 目标类型：x86_64
* 下载地址：[openwrt-18.06.4-x86-64-combined-squashfs.img.gz](https://downloads.openwrt.org/releases/18.06.4/targets/x86/64/openwrt-18.06.4-x86-64-combined-squashfs.img.gz)

解压下载的固件：

```bash
$ x openwrt-18.06.4-x86-64-combined-squashfs.img.gz
or
$ gunzip openwrt-18.06.4-x86-64-combined-squashfs.img.gz
```

Homebrew 安装 qmeu <sup>[[1]](#qemu)</sup>，转换固件镜像格式为虚拟机可使用的 `vmdk` :

```bash
$ brew install qmeu
$ qemu-img convert -f raw openwrt-18.06.4-x86-64-combined-squashfs.img -O vmdk openwrt-x86_64.vmdk
```

得到 `openwrt-x86_64.vmdk` 虚拟磁盘文件

## 安装 OpenWrt 镜像

新建一个 OpenWrt 的虚拟机

* 新建 ---> 创建自定虚拟机
* 选择操作系统 ---> Linux 其他 Linux 4.x 或更高版本内核 64 位
* 选择固件 ---> 默认即可
* 选择虚拟磁盘 ---> 默认即可
* 完成

虚拟机添加硬盘

* 虚拟机创建完成后，即会弹出设置菜单，选择右上角 “添加设备”
* 选择 “现有磁盘”，添加 `openwrt-x86_64.vmdk` 虚拟磁盘文件 ---> 制作虚拟磁盘的单独副本 ---> 应用

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_15-14-13.png %})

设置虚拟机硬盘

* 设置 openwrt-x86_64.vmdk 容量为 5G
* 更改 “高级选项” 中的 “总线类型” 为 IDE
* 勾选 “高级选项” 中的 “拆分为多个文件”
* 移除新建虚拟机时默认创建的 SCSI 格式的硬盘 ---> “高级选项” ---> “移除硬盘”

添加网络适配器 <sup>[[2]](#virtualization)</sup>

* 打开虚拟机设置菜单，选择右上角 “添加设备”
* 选择 “网络适配器”，添加即可
* 重复上述步骤，再添加一个网络适配器

> **说明：** 
> 1. 至此，我们得到三个虚拟网卡 eth0、eth1、eth2
> 2. 虚拟机的 eth0 作为 mng (管理) 接口，固定 ip：192.168.56.2，模式 - **仅主机**，用于管理路由器
> 3. 虚拟机的 eth1 作为 wan 接口，动态 ip 地址，模式 - **NAT**，用于路由器联网
> 4. 虚拟机的 eth2 作为 lan 接口，动态 ip 地址，模式 - **桥接**，用于为其他设备提供联网

设置网络适配器 <sup>[[3]](#vmware)</sup>

* 打开 VMware，菜单拦 ---> 虚拟机，设置网络适配器模式
* 网络适配器2 ---> NAT 模式，使虚拟机可以上网
* 网络适配器3 ---> 桥接模式，使虚拟机可以供其他设备使用，即连接路由器 lan 口

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_13-48-22.png %})

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_13-53-38.png %})

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_13-53-50.png %})

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_13-54-01.png %})

设置适用于 OpenWrt 网络适配器的仅主机模式  <sup>[[4]](#hostonly)</sup>，隔离虚拟机和主机，但仍然可以通信，相当于通过网线互联

* 打开 VMware，偏好设置 ---> 网络（如果此处置灰无法操作，重启电脑即可）
* 添加自定义网络 openwrt-host-only，设置子网 IP `192.168.25.0`
* 打开 VMware，菜单拦 ---> 虚拟机，设置网络适配器模式
* 网络适配器 ---> 自定（openwrt-host-only）

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_13-51-04.png %})

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_13-51-28.png %})

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_13-55-41.png %})

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-10_14-08-51.png %})

## 使用 OpenWrt

OpenWrt 官方镜像 默认地址为：192.168.1.1，并没有设置默认密码。

大多数情况，192.168.1.1 会与本地路由器的地址相冲突，因此首次启动 OpenWrt 时，便需要对网卡进行一些设置才可正常使用。之后可以通过 OpenWrt 的 Web 后台管理界面 `luci` 对其进行管理。

### 首次启动，配置联网

查看网络信息：

```bash
$ uci show network

network.loopback=interface
network.loopback.ifname='lo'
network.loopback.proto='static'
network.loopback.ipaddr='127.0.0.1'
network.loopback.netmask='255.0.0.0'
network.globals=globals
network.globals.ula_prefix='fd1b:e541:8f1a::/48'
network.lan=interface
network.lan.type='bridge'
network.lan.ifname='eth0'
network.lan.proto='static'
network.lan.netmask='255.255.255.0'
network.lan.ipaddr='192.168.1.1'
network.lan.ip6assign='60'
network.wan=interface
network.wan.ifname='eth1'
network.wan.proto='dhcp'
network.wan6=interface
network.wan6.ifname='eth1'
network.wan6.proto='dhcpv6'
```

编辑网络配置信息，以允许 SSH 连接：

```bash
$ uci set network.lan.ipaddr='192.168.25.2'
$ uci commit
$ /etc/init.d/network restart
```

此时，在 Mac 端即可以使用 SSH 连接 OpenWrt 虚拟机 (root 未设置密码)：

```bash
$ ssh root@192.168.25.2
```

继续配置，复制-粘贴以下代码并回车：

```bash
uci batch <<EOF
set network.mng=interface
set network.mng.type='bridge'
set network.mng.proto='static'
set network.mng.netmask='255.255.255.0'
set network.mng.ifname='eth0'
set network.mng.ipaddr='192.168.25.2'
delete network.lan
delete network.wan6
set network.wan=interface
set network.wan.ifname='eth1'
set network.wan.proto='dhcp'
set network.lan=interface
set network.lan.ifname='eth2'
set network.lan.proto='dhcp'
EOF
```

输入 `uci changes` 来确认配置是否被正确加载：

```bash
$ root@OpenWrt:~# uci changes

network.mng='interface'
network.mng.type='bridge'
network.mng.proto='static'
network.mng.netmask='255.255.255.0'
network.mng.ifname='eth0'
network.mng.ipaddr='192.168.25.2'
-network.lan
-network.wan6
network.wan='interface'
network.lan='interface'
network.lan.ifname='eth2'
network.lan.proto='dhcp'
```

保存配置并重启 network 服务：

```bash
$ uci commit && /etc/init.d/network restart
```

确认是否可以联网：

<details>
  <summary class="btn">点击展开详情</summary>
  <pre class="highlight mt1">
  <code>$ root@OpenWrt:~# opkg update
Downloading http://downloads.openwrt.org/releases/18.06.4/targets/x86/64/packages/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_core
Downloading http://downloads.openwrt.org/releases/18.06.4/targets/x86/64/packages/Packages.sig
Signature check passed.
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/base/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_base
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/base/Packages.sig
Signature check passed.
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/luci/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_luci
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/luci/Packages.sig
Signature check passed.
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/packages/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_packages
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/packages/Packages.sig
Signature check passed.
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/routing/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_routing
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/routing/Packages.sig
Signature check passed.
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/telephony/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_telephony
Downloading http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/telephony/Packages.sig
Signature check passed.</code></pre>
</details>

### 使用 LuCI 管理路由器

#### 安装 LuCI 中文语言包

OpenWrt 18.06.4 已经默认安装了 LuCI，之前的版本可能需要手动安装。

```bash
# 养成 update 的好习惯，可以规避很多安装失败
$ opkg update && opkg install luci
```

此时，可以使用浏览器访问：[http://192.168.25.2/](http://192.168.25.2/)，对路由器进行管理。

安装中文语言包：

```bash
$ opkg install luci-i18n-base-zh-cn
or
访问 http://192.168.25.2/ LuCI ---> 系统 ---> 软件包 ---> 搜索 luci-i18n-base-zh-cn, 点击安装
```

刷新 [http://192.168.25.2/](http://192.168.25.2/)，即可看到中文界面

#### 一些常用设置

* 设置密码

LuCI ---> 系统 ---> 管理权 ---> 主机密码

可以在 LuCI 中设置密码，即路由器 root 用户的密码；也可以在 SSH 中，使用 `passwd` 命令进行设置

* 设置时区

LuCI ---> 系统 ---> 系统 ---> 系统属性 ---> 基本设置

更改时区为：Asia/Shanghai

* 设置默认语言

LuCI ---> 系统 ---> 系统 ---> 系统属性 ---> 语言和界面

更改语言为：中文（Chinese）

* 设置 NTP 时间同步

LuCI ---> 系统 ---> 系统 ---> 时间同步

[使用阿里云NTP服务器](https://help.aliyun.com/document_detail/92704.html)，添加阿里云提供的公网 NTP 服务地址：`ntp1.aliyun.com`、`ntp2.aliyun.com` ...

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_15-53-32.png %})

* 更换源

LuCI ---> 系统 ---> 软件包 ---> 配置

添加 `# ` 前缀忽略 `发行版软件源`，在 `自定义软件源` 中填入 [清华镜像源](https://mirrors.ustc.edu.cn/help/lede.html) 的地址：

```
# add your custom package feeds here
#
# src/gz example_feed_name http://www.example.com/path/to/files
src/gz openwrt_core http://mirrors.ustc.edu.cn/lede/releases/18.06.4/targets/x86/64/packages
src/gz openwrt_base http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/base
src/gz openwrt_luci http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/luci
src/gz openwrt_packages http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/packages
src/gz openwrt_routing http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/routing
src/gz openwrt_telephony http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/telephony
```

![]({{ site.baseurl }}{% link assets/images/Snipaste_2019-09-08_15-54-49.png %})

* 备份

LuCI ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 备份

点击 “生成备份”，保存即可

* 恢复出厂模式

LuCI ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 恢复

恢复到出厂设置，点击 “执行重置” 即可

> **注意：** 
> 1. 恢复出厂模式后，所做的所有更改都被重置，仅保留自定义软件源（这意味着如果之前有更改路由器默认 IP 的话，我们将不能通过 web 导入备份执行恢复）
> 2. 不小心执行恢复出厂模式后，可以重新设置路由器 IP，然后访问 LuCI Web，通过导入备份，重新恢复我们对路由器的设置，但软件包仍然需要我们另行安装 (重新设置路由器 IP：`uci set network.lan.ipaddr='192.168.25.2' && uci commit && /etc/init.d/network restart`)

* 恢复配置

LuCI ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 恢复

恢复配置，选择备份文件，点击 “上传备份” 即可

* 刷写新的固件

LuCI ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 刷写新的固件

选择要升级的固件，点击 “刷写固件” 即可

> **注意：** 使用带有 `squashfs` 后缀的官方固件升级，之前的相应配置也将得到保留

#### 安装软件包

安装方式：

* 浏览器访问 LuCI Web [http://192.168.25.2/](http://192.168.25.2/)：LuCI ---> 系统 ---> 软件包
* 使用 SSH 连接虚拟机，执行 `opkg install [software name]`

列举一些常用软件包：

| 软件包 | 描述 |
| ----| ---- |
| luci-i18n-base-zh-cn | luci 界面中文汉化包 |

## 小结

如需恢复出厂设置：

```
LuCI ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 恢复 ---> 恢复到出厂设置，点击 “执行重置”

# or

SSH 登陆 OpenWrt，执行 firstboot，重启
```

恢复出厂后，重新恢复 OpenWrt：

```bash
# 1. 恢复路由器 IP 设置
#启动虚拟机 OpenWrt，执行
$ uci set network.lan.ipaddr='192.168.25.2' && uci commit && /etc/init.d/network restart

# 2. 恢复自定义配置
#浏览器访问 http://192.168.25.2/
恢复配置：LuCI ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 恢复 ---> 恢复配置，选择备份文件，点击 “上传备份” 即可
恢复软件源更改：LuCI ---> 系统 ---> 软件包 ---> 配置 ---> 添加 '#' 前缀忽略发行版软件源

# 3. 恢复软件包
##安装之前的软件包，如中文语言包
$ opkg update && opkg install luci-i18n-base-zh-cn
```

升级固件：

```
# 下载带有 squashfs 后缀的官方固件进行升级，可以保留之前的配置
LuCI ---> 系统 ---> 备份/升级 ---> 刷新操作 ---> 刷写新的固件 ---> 选择要升级的固件，点击 “刷写固件” 即可
```

## Reference

* <span id="qemu">[1. 使​用​ qemu-img](https://docs.fedoraproject.org/zh-CN/Fedora/12/html/Virtualization_Guide/sect-Virtualization_Guide-Tips_and_tricks-Using_qemu_img.html)</span>
* <span id="virtualization">[2. 在 Virtualbox 虚拟机中运行 OpenWrt](https://openwrt.org/zh/docs/guide-user/virtualization/virtualbox-vm)</span>
* <span id="vmware">[3. VMware 三种网络连接方式：Bridge、NAT、Host-Only的区别](https://blog.csdn.net/rickiyeat/article/details/55097687)</span>
* <span id="hostonly">[4. Mac 的 VMware Fusion 自定义 Host-only 的 IP 步骤](https://my.oschina.net/u/3606160/blog/3015720)</span>