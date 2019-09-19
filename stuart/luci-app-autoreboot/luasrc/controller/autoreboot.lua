module("luci.controller.autoreboot",package.seeall)

function index()
    entry({"admin", "custom"}, firstchild(), "我的", 89).dependent = false
	local page
	page = entry({"admin", "custom", "autoreboot"}, cbi("autoreboot"), _("Scheduled Reboot"), 997)
	page.i18n = "autoreboot"
    page.dependent = true
end
