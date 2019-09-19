# 安装软件（在线/离线

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

如果 LuCI 有安装 `文件助手` 的话，可直接在 LuCI 中安装，详见 [移植软件包 - 文件助手](https://stuarthua.github.io/oh-my-openwrt/mybook/packages/use-package-filetransfer.html)