-- Copyright (C) 2014-2017 Jian Chang <aa65535@live.com>
-- Licensed to the public under the GNU General Public License v3.

module("luci.controller.shadowsocks", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/shadowsocks") then
		return
	end

	entry({"admin", "custom"}, firstchild(), "我的", 89).dependent = false
	entry({"admin", "custom", "shadowsocks"},
		alias("admin", "custom", "shadowsocks", "general"),
		_("ShadowSocks"), 400).dependent = true

	entry({"admin", "custom", "shadowsocks", "general"},
		cbi("shadowsocks/general"),
		_("General Settings"), 10).leaf = true

	entry({"admin", "custom", "shadowsocks", "status"},
		call("action_status")).leaf = true

	entry({"admin", "custom", "shadowsocks", "servers"},
		arcombine(cbi("shadowsocks/servers"), cbi("shadowsocks/servers-details")),
		_("Servers Manage"), 20).leaf = true

	if luci.sys.call("command -v ss-redir >/dev/null") ~= 0 then
		return
	end

	entry({"admin", "custom", "shadowsocks", "access-control"},
		cbi("shadowsocks/access-control"),
		_("Access Control"), 30).leaf = true
end

local function is_running(name)
	return luci.sys.call("pidof %s >/dev/null" %{name}) == 0
end

function action_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		ss_redir = is_running("ss-redir"),
		ss_local = is_running("ss-local"),
		ss_tunnel = is_running("ss-tunnel")
	})
end
