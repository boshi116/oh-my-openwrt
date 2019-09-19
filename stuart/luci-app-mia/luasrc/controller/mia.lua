module("luci.controller.mia", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/mia") then return end

    entry({"admin", "custom"}, firstchild(), "我的", 89).dependent = false
    entry({"admin", "custom", "mia"}, cbi("mia"), _("上网时间管理"), 600).dependent = true
    entry({"admin", "custom", "mia", "status"}, call("status")).leaf = true
end

function status()
    local e = {}
    e.status = luci.sys.call("iptables -L FORWARD |grep MIA >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
