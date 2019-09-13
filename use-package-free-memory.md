---
title: 移植软件包 - 释放内存
parent: 使用软件包
nav_order: 3
---

# 移植软件包 - 释放内存

以 `释放内存` 为例，以下记录移植 Lean OpenWrt 软件包的过程，仅供参考

## 获取软件包源码

* 软件包: 释放内存
* 源码地址: [lede/luci-app-ramfree](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-ramfree)

原效果预览：

![Snipaste_2019-09-13_16-52-33.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-13_16-52-33.png)

拷贝存放至自己的仓库中 [stuarthua/oh-my-openwrt](https://github.com/stuarthua/oh-my-openwrt), 目录如下

```
stuart
├── helloworld
├── luci-app-stuart
└── luci-app-ramfree
```

## 定制软件包

阅读: [使用软件包 - 自定义 Luci 菜单](https://stuarthua.github.io/oh-my-openwrt/use-package-stuart.html)

比较建议的做法是，定制软件包时，将所有的软件包 LuCI 可视化操作统一归置到 自定义菜单中，方便后续拓展。

现在，我们希望，`释放内存` 在 LuCI 中挪至单独的菜单 `Stuart` 中，便于后续的升级拓展。

修改后效果预览：

![Snipaste_2019-09-13_20-53-52.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-13_20-53-52.png)

修改版源码见: [stuart/luci-app-ramfree](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-ramfree), 依赖 `luci-app-stuart`

## 使用 SDK 编译软件包

参考: [使用 SDK 编译特定软件包](https://stuarthua.github.io/oh-my-openwrt/make-by-sdk.html)

Mac 上使用 SSH 连接 Ubuntu

更新第三方软件包代码

```bash
cd ~/oh-my-openwrt && git pull
```

feeds 更新并安装

```bash
cd ~/openwrt-sdk-x86 && ./scripts/feeds update -a && ./scripts/feeds install -a
```

单独更新 stuart

```
cd ~/openwrt-sdk-x86 && ./scripts/feeds update stuart && ./scripts/feeds install -a -p stuart
```

进入 `~/openwrt-sdk-x86`, 开始编译

```bash
cd ~/openwrt-sdk-x86 && make package/luci-app-ramfree/compile V=s
```

在 `~/sdk-ipks/x86` 目录查看生成的软件包

```
x86
└── luci-app-ramfree_1.0-1_all.ipk
```

生成 ipk 文件 `luci-app-ramfree_1.0-1_all.ipk`

## 安装及使用

参考: [使用软件包 - HelloWorld](https://stuarthua.github.io/oh-my-openwrt/use-package-helloworld.html)

原生 OpenWrt 固件默认没有开启 sftp 服务，需要我们手动安装并开启

```bash
opkg update
opkg install vsftpd openssh-sftp-server
/etc/init.d/vsftpd enable
/etc/init.d/vsftpd start
```

使用 [Cyberduck](https://cyberduck.io/) 上传 ipk 安装包至路由器

Mac 上使用 SSH 连接路由器，执行安装

```bash
opkg install luci-app-ramfree_1.0-1_all.ipk
```

安装后，如果界面没有变化，可以尝试移除 luci 缓存，刷新页面

```bash
rm -rf /tmp/luci-*
```

也可以尝试重启 `http` 服务，在刷新页面

```bash
/etc/init.d/uhttpd restart
```

如需卸载，执行

```bash
opkg remove luci-app-ramfree
```
