module("luci.controller.autoreboot",package.seeall)

function index()
    entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
	local page
	page = entry({"admin", "stuart", "autoreboot"}, cbi("autoreboot"), _("Scheduled Reboot"), 997)
	page.i18n = "autoreboot"
    page.dependent = true
end
