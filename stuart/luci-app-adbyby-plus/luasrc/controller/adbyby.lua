module("luci.controller.adbyby", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/adbyby") then return end
	
	entry({"admin", "custom"}, firstchild(), "我的", 89).dependent = false
	entry({"admin", "custom", "adbyby"}, cbi("adbyby"), _("ADBYBY Plus +"), 300).dependent = true
	entry({"admin", "custom", "adbyby", "status"}, call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("pgrep adbyby >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
