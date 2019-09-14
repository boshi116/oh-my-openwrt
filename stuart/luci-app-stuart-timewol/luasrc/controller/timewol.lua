module("luci.controller.timewol", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/timewol") then return end

    entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
    entry({"admin", "stuart", "timewol"}, cbi("timewol"), _("定时唤醒"), 996).dependent = true
    entry({"admin", "stuart", "timewol", "status"}, call("status")).leaf = true
end

function status()
    local e = {}
    e.status = luci.sys.call("cat /etc/crontabs/root |grep etherwake >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end