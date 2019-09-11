# openwrt-package

---

OpenWrt Packages For Commonly Using

Reading：[gh-pages](https://stuarthua.github.io/oh-my-openwrt/)

## Usage

Edit `feeds.conf.default`, add below line

```
src-git stuart https://github.com/stuarthua/openwrt-package
```

Execute

```bash
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

Make and Enjoy.