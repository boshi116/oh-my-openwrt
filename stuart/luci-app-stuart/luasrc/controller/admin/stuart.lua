module("luci.controller.admin.stuart",package.seeall)

function index()
	entry({"admin", "stuart"}, firstchild(), _("Stuart"), 30).index = true
	entry({"admin", "stuart", "helloworld"}, template("stuart/helloworld"), "HelloWorld", 1)
end
