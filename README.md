# oh my openwrt

---

Using OpenWrt Experience

Reading：[gh-pages](https://stuarthua.github.io/oh-my-openwrt/)

## Usage

### Make From Source Code

Edit `feeds.conf.default`, add below line

```
src-git stuart https://github.com/stuarthua/oh-my-openwrt
```

Execute

```bash
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

Make and Enjoy.

### Use My IPK Files

checkout devices

```bash
$ git clone https://github.com/stuarthua/oh-my-openwrt
$ git checkout -b devices origin/devices 
```

Use Image Builder to gen your image.

## Thanks

* [openwrt/openwrt](https://github.com/openwrt/openwrt)
* [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)
* [Lienol/openwrt-package](https://github.com/Lienol/openwrt-package)