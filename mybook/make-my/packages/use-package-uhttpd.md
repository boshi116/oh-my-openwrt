# 使用软件包 uHTTPd

uHTTPd, 一个轻量级单线程 HTTP(S) 服务器。用于在 LuCI 界面中设置 Https

> 需要使用 DDNS 远程访问 OpenWrt 路由器的话，推荐开启 Https 访问

## 安装

```
opkg update
opkg install luci-i18n-base-zh-cn
opkg install uhttpd luci-app-uhttpd luci-i18n-uhttpd-zh-cn
```

## 使用

LuCI ---> 服务 ---> uHTTPd



