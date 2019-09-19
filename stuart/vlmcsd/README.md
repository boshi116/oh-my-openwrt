# vlmcsd

> KMS 自动激活程序 (用于激活大客户版 Windows 及 Office，最新支持至 Windows 10 1809, Windows Server 2019 and Office 2019 built-in) 的依赖包，需搭配 luci-app-vlmcsd 进行使用

更多描述，详见: [移植软件包 - KMS 自动激活程序](https://stuarthua.github.io/oh-my-openwrt/mybook/packages/use-package-kms.html)

## 说明

移植自 

* [lean/luci-app-vlmcsd](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-vlmcsd)
* [lean/vlmcsd](https://github.com/coolsnowwolf/lede/tree/master/package/lean/vlmcsd)

luci-app-vlmcsd 依赖 vlmcsd, 而 vlmcsd 是一个第三方程序，编译它依赖：

* POSIX 线程库 - [官方 - libpthread](https://openwrt.org/packages/pkgdata/libpthread)

### 关于 vlmcsd

[lean/vlmcsd](https://github.com/coolsnowwolf/lede/tree/master/package/lean/vlmcsd) 会下载 [etnperlong/vlmcsd](https://github.com/etnperlong/vlmcsd) 的源码进行编译。而 [etnperlong/vlmcsd](https://github.com/etnperlong/vlmcsd) 则 Fork 自 [cokebar/vlmcsd](https://github.com/cokebar/vlmcsd)，其最终都是来自 [mydigitallife](http://forums.mydigitallife.info/threads/50234)。除了 etnperlong 和 cokebar 整理的版本，使用最多的还是 [Wind4/vlmcsd](https://github.com/Wind4/vlmcsd)，在这里，提供了一些可供使用的激活码 [Wind4/gh-pages](https://github.com/Wind4/vlmcsd/tree/gh-pages)

[mydigitallife](http://forums.mydigitallife.info/threads/50234) 中关于 vlmcsd 的介绍

![Snipaste_2019-09-14_17-52-51.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_17-52-51.png)

[Wind4/gh-pages](https://github.com/Wind4/vlmcsd/tree/gh-pages) 中提供的激活码

![Snipaste_2019-09-14_17-59-10.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-09-14_17-59-10.png)

## 使用

参考 [在 VPS 中利用 vlmcsd 搭建 KMS 激活服务器](https://imeiji.github.io/2018/02/08/%E5%88%A9%E7%94%A8vlmcsd%E6%90%AD%E5%BB%BAKMS%E6%BF%80%E6%B4%BB%E6%9C%8D%E5%8A%A1%E5%99%A8/)