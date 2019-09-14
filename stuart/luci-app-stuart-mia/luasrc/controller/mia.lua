module("luci.controller.mia", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/mia") then return end

    entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
    entry({"admin", "stuart", "mia"}, cbi("mia"), _("时间控制"), 993).dependent = true
    entry({"admin", "stuart", "mia", "status"}, call("status")).leaf = true
end

function status()
    local e = {}
    e.status = luci.sys.call("iptables -L FORWARD |grep MIA >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
