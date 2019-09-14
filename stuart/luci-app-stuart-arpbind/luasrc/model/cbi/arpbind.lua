local sys = require "luci.sys"
local ifaces = sys.net:devices()

m = Map("arpbind", translate("IP/MAC Binding"),
        translatef("ARP 协议是用于实现网络地址到物理地址转换的协议。在这里，你可以设置静态ARP绑定规则。"))

s = m:section(TypedSection, "arpbind", translate("Rules"))
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

a = s:option(Value, "ipaddr", translate("IP Address"))
a.optional = false
a.datatype = "ipaddr"
luci.ip.neighbors({ family = 4 }, function(entry)
       if entry.reachable then
               a:value(entry.dest:string())
       end
end)

a = s:option(Value, "macaddr", translate("MAC 地址"))
a.datatype = "macaddr"
a.optional = false
luci.ip.neighbors({family = 4}, function(neighbor)
	if neighbor.reachable then
		a:value(neighbor.mac, "%s (%s)" %{neighbor.mac, neighbor.dest:string()})
	end
end)

a = s:option(ListValue, "ifname", translate("Interface"))
for _, iface in ipairs(ifaces) do
	if iface ~= "lo" then 
		a:value(iface) 
	end
end
a.default = "br-lan"
a.rmempty = false

return m


