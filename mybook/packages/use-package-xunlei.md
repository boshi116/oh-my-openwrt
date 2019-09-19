# 移植软件包 - 迅雷快鸟

[官网 - 迅雷快鸟](https://k.xunlei.com/)，是迅雷与中国电信、中国联通合作推出的一项上网加速服务，技术原理为大幅提高用户现有物理宽带带宽，提升上网速度。但有提速范围但限制，超过 200M 网速的宽带无法提速。

查看提速范围：[官网 - 提速范围](https://k.xunlei.com/vip.html?type=kn#kn_box)

最终效果预览：

![Snipaste_2019-09-15_00-00-11.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-15_00-00-11.png)

修改版源码见: [stuart/luci-app-stuart-xlnetacc](https://github.com/stuarthua/oh-my-openwrt/tree/master/stuart/luci-app-stuart-xlnetacc)

## 说明

移植自 [lean/luci-app-xlnetacc](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-xlnetacc)

依赖：

* 从 shell 脚本解析和生成 JSON 的库 - [官方 - jshn](https://openwrt.org/packages/pkgdata/jshn)
* 命令行下载工具 - [官方 - wget](https://openwrt.org/packages/pkgdata/wget)
* openssl-util - [官方 - openssl-util](https://openwrt.org/packages/pkgdata/openssl-util)
