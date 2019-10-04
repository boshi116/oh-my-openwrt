# 使用软件包 Adblock

Adblock 去广告

## 安装

```
opkg update
opkg install luci-i18n-base-zh-cn
opkg install libustream-openssl
opkg install adblock luci-app-adblock luci-i18n-adblock-zh-cn
```

## 使用

LuCI ---> 服务 ---> Adblock

![Snipaste_2019-10-03_14-39-37.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-10-03_14-39-37.png)

勾选启用

![Snipaste_2019-10-03_14-40-29.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-10-03_14-40-29.png)

勾选 `reg_cn` 拦截列表，拦截国内广告

LuCI ---> 服务 ---> Adblock ---> 高级 ---> 编辑黑名单

![Snipaste_2019-10-03_14-41-49.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-10-03_14-41-49.png)

添加屏蔽小米广告的域名 (引自小米净化APP)

```
a.stat.xiaomi.com
a.union.mi.com
abtest.mistat.xiaomi.com
adinfo.ra1.xlmc.sec.miui.com
adv.sec.miui.com
api.ad.xiaomi.com
api.ra2.xlmc.sec.miui.com
api.tuisong.baidu.com
api.tw06.xlmc.sec.miui.com
app01.nodes.gslb.mi-idc.com
app02.nodes.gslb.mi-idc.com
app03.nodes.gslb.mi-idc.com
applog.uc.cn
beha.ksmobile.com
bss.pandora.xiaomi.com
calopenupdate.comm.miui.com
cdn.ad.xiaomi.com
cm.p4p.cn.yahoo.com
cm066.getui.igexin.com
connect.rom.miui.com
data.mistat.xiaomi.com
e.ad.xiaomi.com
etl.xlmc.sandai.net
fcanr.tracking.miui.com
fclick.baidu.com
get.sogou.com
hm.xiaomi.com
hub5pn.wap.sandai.net
idx.m.hub.sandai.net
image.box.xiaomi.com
info.analysis.kp.sec.miui.com
info.sec.miui.com
logupdate.avlyun.sec.miui.com
m.bss.pandora.xiaomi.com
m.irs01.com
m.sjzhushou.com
master.wap.dphub.sandai.net
mdap.alipaylog.com
migc.g.mi.com
migcreport.g.mi.com
migrate.driveapi.micloud.xiaomi.net
mis.g.mi.com
mlog.search.xiaomi.net
new.api.ad.xiaomi.com
notice.game.xiaomi.com
nsclick.baidu.com
o2o.api.xiaomi.com
p.alimama.com
pdc.micloud.xiaomi.net
ppurifier.game.xiaomi.com
pre.api.tw06.xlmc.sandai.net
r.browser.miui.com
reader.browser.miui.com
report.adview.cn
resolver.gslb.mi-idc.com
resolver.msg.xiaomi.net
sa.tuisong.baidu.com
sa3.tuisong.baidu.com
sdk.open.phone.igexin.com
sdk.open.talk.gepush.com
sdk.open.talk.igexin.com
sdkconfig.ad.xiaomi.com
sec-cdn.static.xiaomi.net
sec.resource.xiaomi.net
security.browser.miui.com
sg.a.stat.mi.com
staging.admin.e.mi.com
test.ad.xiaomi.com
test.api.xlmc.sandai.net
test.e.ad.xiaomi.com
test.new.api.ad.xiaomi.com
tracking.miui.com
tw13b093.sandai.net
union.dbba.cn
update.avlyun.sec.miui.com
www.adview.cn
yun.rili.cn
zhwnlapi.etouch.cn
api.comm.miui.com
```

重启路由器即可。

如果想手动更新屏蔽列表，LuCI ---> 服务 ---> Adblock

![Snipaste_2019-10-03_14-44-57.png](https://raw.githubusercontent.com/stuarthua/PicGo/master/oh-my-openwrt/Snipaste_2019-10-03_14-44-57.png)

点击 `Refresh` 即可。

测试视频：

* 优酷：http://v.youku.com/v_show/id_XMTQ2MjA5MzE5Ng==.html
* 爱奇艺：http://www.iqiyi.com/v_19rrl6p15k.html
* 腾讯视频：http://v.qq.com/cover/5/5fs2bn3beyv0rbo/r00192d3ruz.html
* 乐视网：http://www.letv.com/ptv/vplay/24371048.html
* 芒果 TV：http://www.mgtv.com/v/2/166072/f/2949223.html
* PPTV 聚力：http://v.pptv.com/show/4atBviaaMicDqdGibc.html

