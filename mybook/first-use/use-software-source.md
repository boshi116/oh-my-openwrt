# 使用 OpenWrt 软件源

一般而言，通用的软件包都可以在官方源中找到并安装，这一点十分方便，但一些特定的软件包在官方源中并不能找到，这就需要添加自定义软件源使用第三方软件，或者自行编译适合自己硬件的软件包。

## 官方软件源

官方 `发行版软件源` 在系统升级后，有可能更改，且国内访问的速度不佳，可以考虑使用 `清华的镜像源` 进行替换，建议置于 `自定义软件源`，跟随系统升级。

LuCI ---> 系统 ---> 软件包 ---> 配置

添加 `# ` 前缀忽略 `发行版软件源`，在 `自定义软件源` 中填入 [科技大镜像源](https://mirrors.ustc.edu.cn/help/lede.html) 的地址：

```
src/gz openwrt_core http://mirrors.ustc.edu.cn/lede/releases/18.06.4/targets/x86/64/packages
src/gz openwrt_base http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/base
src/gz openwrt_luci http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/luci
src/gz openwrt_packages http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/packages
src/gz openwrt_routing http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/routing
src/gz openwrt_telephony http://mirrors.ustc.edu.cn/lede/releases/18.06.4/packages/x86_64/telephony
```

也可以使用其高速镜像源 `openwrt.proxy.ustclug.org` 的地址：

```
src/gz openwrt_core http://openwrt.proxy.ustclug.org/releases/18.06.4/targets/x86/64/packages
src/gz openwrt_base http://openwrt.proxy.ustclug.org/releases/18.06.4/packages/x86_64/base
src/gz openwrt_luci http://openwrt.proxy.ustclug.org/releases/18.06.4/packages/x86_64/luci
src/gz openwrt_packages http://openwrt.proxy.ustclug.org/releases/18.06.4/packages/x86_64/packages
src/gz openwrt_routing http://openwrt.proxy.ustclug.org/releases/18.06.4/packages/x86_64/routing
src/gz openwrt_telephony http://openwrt.proxy.ustclug.org/releases/18.06.4/packages/x86_64/telephony
```

> 注意是否使用 https 取决于 OpenWrt 是否已经安装 ssl/tls, ca 证书 等相关软件包

效果预览：

![](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-08_15-54-49.png)

官方源：

```
src/gz openwrt_core http://downloads.openwrt.org/releases/18.06.4/targets/x86/64/packages
src/gz openwrt_base http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/base
src/gz openwrt_luci http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/luci
src/gz openwrt_packages http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/packages
src/gz openwrt_routing http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/routing
src/gz openwrt_telephony http://downloads.openwrt.org/releases/18.06.4/packages/x86_64/telephony
```

## 自定义软件源

官方推荐的适用于有外部存储设备的软件包第三方源

* [http://www.ipkg.be/](http://www.ipkg.be/)
* [http://ipkg.nslu2-linux.org/feeds/optware/ddwrt/cross/stable](http://ipkg.nslu2-linux.org/feeds/optware/ddwrt/cross/stable)

国内爱好者组织 [openwrt.io](https://openwrt.io) 推荐的源 (已接近断更，慎用)：

```
# 极路由 gee ralink opkg 源（j1s、 j2、 j3）

官方源：
src/gz barrier_breaker https://upgrade.hiwifi.com/upgrade_file/ralink-HC5661/0.9011.1.9228s/packages
src/gz barrier_breaker https://upgrade.hiwifi.com/upgrade_file/ralink-HC5761/0.9012.1.9277s/packages
src/gz barrier_breaker https://upgrade.hiwifi.com/upgrade_file/ralink-HC5861/0.9013.1.9653s/packages
openwrt.io 源：
src/gz openwrtio http://dl.openwrt.io/vendors/gee/ralink/packages

# 极路由gee mediatek opkg 源（j1s新版 HC5661A）

官方源：
src/gz barrier_breaker https://upgrade.hiwifi.com/upgrade_file/mediatek-HC5661A/0.9011.1.9117s/packages
openwrt.io 源：
src/gz openwrtio http://dl.openwrt.io/vendors/gee/mediatek/packages

# 极路由 gee ar71xx opkg 源（j1）
官方源：
src/gz barrier_breaker https://upgrade.hiwifi.com/upgrade_file/ar71xx-HC6361/0.9008.2.8061s/packages
openwrt.io 源：
src/gz openwrtio http://dl.openwrt.io/vendors/gee/ar71xx/packages

# 优酷 youku ramips opkg 源（YK-L1）
官方源：
src/gz youku http://desktop.youku.com/openwrt/1.5.0418.50280/2/mtn/packages
openwrt.io 源：
src/gz openwrtio http://dl.openwrt.io/vendors/youku/ramips/packages
```

> **注意：** 不推荐使用不信任的第三方提供的软件包，更多情况下，还是推荐自行编译软件包

## 个人常用软件包

一些第三方软件包会强依赖硬件平台，通常需要自行编译。以下是个人常用的软件包，仅供参考。

* [stuarthua/oh-my-openwrt](https://github.com/stuarthua/oh-my-openwrt/)

如需自定义，请参考下节 [编译自己的 OpenWrt 固件及软件包](https://stuarthua.github.io/oh-my-openwrt/mybook/make-my/make-my-openwrt.html)