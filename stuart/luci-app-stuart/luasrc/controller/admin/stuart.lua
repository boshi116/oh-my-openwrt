module("luci.controller.admin.stuart",package.seeall)

function index()
	entry({"admin", "stuart"}, firstchild(), "Stuart", 89).dependent = false
	entry({"admin", "stuart", "helloworld"}, template("helloworld"), "HelloWorld", 1).dependent = true
end