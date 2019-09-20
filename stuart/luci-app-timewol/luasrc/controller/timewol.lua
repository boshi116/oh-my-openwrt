module("luci.controller.timewol", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/timewol") then return end

    entry({"admin", "custom"}, firstchild(), "我的", 89).dependent = false
    entry({"admin", "custom", "timewol"}, cbi("timewol"), _("定时网络唤醒"), 601).dependent = true
    entry({"admin", "custom", "timewol", "status"}, call("status")).leaf = true
end

function status()
    local e = {}
    e.status = luci.sys.call("cat /etc/crontabs/root |grep etherwake >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
