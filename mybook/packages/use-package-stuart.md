# 使用软件包 (示例) - 自定义 LuCI 菜单

使用 OpenWrt, 不可避免的会想要安装一些第三方软件包，对于编译自己的软件包，比较推荐的做法是统一归置到 LuCI 可视化界面的菜单中，方便后续拓展

以个人仓库为例，添加自定义 LuCI 菜单 `luci-app-stuart`

预览：

![Snipaste_2019-09-13_20-57-06.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-13_20-57-06.png)

## 获取软件包源码

* 软件包: luci-app-stuart
* 源码地址: [stuart/luci-app-stuart](https://github.com/stuarthua/oh-my-openwrt/stuart/luci-app-stuart)

## 使用 SDK 编译软件包

参考: [使用 SDK 编译特定软件包](https://stuarthua.github.io/oh-my-openwrt/mybook/make-my/make-by-sdk.html)

Mac 上使用 SSH 连接 Ubuntu

更新第三方软件包代码

```bash
cd ~/oh-my-openwrt && git pull
```

更新并安装全部 feeds

```bash
cd ~/openwrt-sdk-x86 && ./scripts/feeds update -a && ./scripts/feeds install -a
```

单独更新 feeds - stuart

```
cd ~/openwrt-sdk-x86 && ./scripts/feeds update stuart && ./scripts/feeds install -a -p stuart
```

进入 `~/openwrt-sdk-x86`, 开始编译

```bash
cd ~/openwrt-sdk-x86 && make package/luci-app-stuart/compile V=s
```

在 `~/sdk-ipks/x86` 目录查看生成的软件包

```
x86
├── luci-app-stuart_1.0-1_all.ipk
```

生成 ipk 文件 `luci-app-stuart_1.0-1_all.ipk`

## 安装及使用

参考: [使用软件包 (示例) - HelloWorld](https://stuarthua.github.io/oh-my-openwrt/mybook/packages/use-package-helloworld.html)

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
opkg install luci-app-stuart_1.0-1_all.ipk
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
opkg remove luci-app-stuart
```
