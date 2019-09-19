module("luci.controller.terminal", package.seeall)

function index()
	if not (luci.sys.call("pidof ttyd > /dev/null") == 0) then
		return
	end
	
	entry({"admin", "custom"}, firstchild(), "我的", 89).dependent = false
	entry({"admin", "custom", "terminal"}, template("terminal"), _("TTYD Terminal"), 10).leaf = true
end
