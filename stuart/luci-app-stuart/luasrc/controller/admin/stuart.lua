module("luci.controller.admin.stuart",package.seeall)

function index()
	entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
	local page
	page = entry({"admin", "stuart", "helloworld"}, template("helloworld"), "HelloWorld", 1)
	page.i18n = "base"
    page.dependent = true
end