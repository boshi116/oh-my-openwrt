--[[
 静态ARP绑定 Luci页面 Controller
 Copyright (C) 2015 GuoGuo <gch981213@gmail.com>
]]--

module("luci.controller.arpbind", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/arpbind") then
		return
	end
	entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
	page = entry({"admin", "stuart", "arpbind"}, cbi("arpbind"), _("IP/MAC 绑定"), 2)
	page.i18n = "base"
    page.dependent = true
end
