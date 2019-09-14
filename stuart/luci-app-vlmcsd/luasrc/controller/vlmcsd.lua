module("luci.controller.vlmcsd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/vlmcsd") then
		return
	end
	entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
	local page
	page = entry({"admin", "stuart", "vlmcsd"}, cbi("vlmcsd"), _("KMS Server"), 4)
	page.i18n = "vlmcsd"
	page.dependent = true
	entry({"admin", "stuart", "vlmcsd", "status"}, call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("pgrep vlmcsd >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
