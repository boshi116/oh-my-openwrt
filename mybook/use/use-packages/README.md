# 安装软件（在线/离线)

简单介绍 OpenWrt 的软件安装方式，分为在线安装和离线安装两种方式

### 在线安装

* 使用命令行安装

```
opkg install luci-i18n-base-zh-cn
```

* 使用 LuCI 安装

在 LuCI 中搜索 `luci-i18n-base-zh-cn`, 点击安装即可

### 离线安装

* 使用命令行安装

原生 OpenWrt 固件默认没有开启 sftp 服务，需要我们手动安装并开启

```bash
opkg update
opkg install vsftpd openssh-sftp-server
/etc/init.d/vsftpd enable
/etc/init.d/vsftpd start
```

Mac 上厌倦了 `scp` 命令的繁琐，可以使用 [Cyberduck](https://cyberduck.io/) 将 `luci-i18n-base-zh-cn.ipk` 上传至路由器

使用命令行安装

```
opkg install luci-i18n-base-zh-cn.ipk
```

* 使用 LuCI 安装

如果 LuCI 有安装 `文件助手` 的话，可直接在 LuCI 中安装，详见 [移植软件包 - 文件助手](../../make/port/use-package-filetransfer.md)

### 常用命令

更新可用软件包列表

```bash
opkg update
```

升级软件包

```bash
opkg upgrade <pkgs>
```

安装软件包

```bash
opkg install <pkgs>

# 如
opkg install hiawatha
opkg install http://downloads.openwrt.org/snapshots/trunk/ar71xx/packages/hiawatha_7.7-2_ar71xx.ipk
opkg install /tmp/hiawatha_7.7-2_ar71xx.ipk
```

安装软件包时，无视失败的依赖

```bash
opkg install <pkgs> --force-depends
```

移除一个或多个软件包

```bash
opkg remove <pkgs>
```

移除软件包时，无视失败的依赖

```bash
opkg remove <pkgs> --force-depends
```

移除软件包时，移除其所有依赖软件包

```
opkg remove <pkgs> --force-removal-of-dependent-packages
```

显示软件包信息

```bash
opkg info <pkg>
```

列出软件包信息

```bash
opkg list <pkg>
```

列出已安装软件包

```bash
opkg list-installed
```

列出可升级的软件包列表

```bash
opkg list-upgradable
```

下载软件包到当前目录

```bash
opkg download <pkg>
```

列出可安装软件包的架构

```bash
opkg print-architecture
```