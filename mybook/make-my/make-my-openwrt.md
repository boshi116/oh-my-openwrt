# 编译自己的 OpenWrt 固件及软件包

编译 OpenWrt 有多种方式：

* 使用 Image Builder 组装固件镜像
* 使用 OpenWrt SDK 编译软件包
* 使用 OpenWrt 源码编译固件及软件包

相对来讲

* Image Builder 更适合于低内存设备，此类设备 `okpg` 可能无法很好的运行，如 小米路由器青春版；
* 使用 SDK 编译能大大减少时间和出错，因为 SDK 中已经包含了所需的环境
* 使用源码编译当然是最好的，前提是对 OpenWrt 足够熟悉，并能熟练掌握配置技巧。通常，为了减少时间，更推荐使用 SDK 编译

从 OpenWrt 源码编译时，勾选 image builder 和 sdk 这两项之后，可以在编译产物中找到对应硬件的 image builder 和 sdk, 所以，从源码编译是一种适用面很广的编译方式。但使用源码编译，因为要重新编译 cross-compile toolchians，下载内核和软件包的源码，导致这个过程比较耗时，更多时候，还是推荐使用 SDK 编译 ipk，使用 Image Builder 编译固件，可以节省很多时间。

> **注意：** 区分编译固件、编译软件包

## 准备

* Mac
* VMware Fusion 11