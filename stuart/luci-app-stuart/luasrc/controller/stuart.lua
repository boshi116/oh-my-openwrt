module("luci.controller.stuart",package.seeall)

function index()
	entry({"admin", "stuart"}, firstchild(), "Stuart", 30).dependent=false
end
