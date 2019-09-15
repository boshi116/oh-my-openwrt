module("luci.controller.webrestriction", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/webrestriction") then return end

    entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
    entry({"admin", "stuart", "webrestriction"}, cbi("webrestriction"), _("访问限制"), 601).dependent = true
    entry({"admin", "stuart", "webrestriction", "status"}, call("status")).leaf = true
end

function status()
    local e = {}
    e.status = luci.sys.call("iptables -L FORWARD |grep WEB_RESTRICTION >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
