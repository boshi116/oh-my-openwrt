module("luci.controller.admin.stuart",package.seeall)

function index()
	entry({"admin","stuart","release_ram"}, call("release_ram"), _("Release Ram"), 9999)
end
function release_ram()
	luci.sys.call("sync && echo 3 > /proc/sys/vm/drop_caches")
	luci.http.redirect(luci.dispatcher.build_url("admin/status"))
end
