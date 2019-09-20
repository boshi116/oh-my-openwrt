-- Copyright (C) 2014-2018 OpenWrt-dist
-- Copyright (C) 2014-2018 Jian Chang <aa65535@live.com>
-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.chinadns", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/chinadns") then
		return
	end
	entry({"admin", "custom"}, firstchild(), "我的", 89).dependent = false
	entry({"admin", "custom", "chinadns"}, cbi("chinadns"), _("ChinaDNS"), 401).dependent = true
end
