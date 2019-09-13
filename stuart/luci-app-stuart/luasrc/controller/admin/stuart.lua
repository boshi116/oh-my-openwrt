module("luci.controller.admin.stuart",package.seeall)

function index()
	entry({"admin", "stuart"}, firstchild(), _("Stuart"), 89).index = true
	entry({"admin", "stuart", "helloworld"}, template("helloworld"), "HelloWorld", 1)
end
