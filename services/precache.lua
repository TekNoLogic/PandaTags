
local myname, ns = ...


local MATS = {
	22450, 20725, 34057, 52722,
	52720, 52721,
	11178, 14343, 14344, 22448, 22449, 34052,
	10978, 11084, 11138, 11139, 11177, 34053,
	52718, 52719,
	11174, 11175, 16202, 16203, 22447, 22446, 34056, 34055,
	10938, 10939, 10998, 11082, 11134, 11135,
	10940, 11083, 11137, 11176, 16204, 22445, 34054, 52555,
	74248, 74247, 74252, 74249, 74250,
	109693, 111245, 113588,
	124440, 124441, 124442,
}
local ids = {}
for _,id in pairs(MATS) do ids[id] = true end


local function Scan()
	for id in pairs(ids) do
		if GetItemInfo(id) then ids[id] = nil end
	end
end


local function OnItemInfoReceived(self, event, item_id)
	ids[item_id] = nil
	if not next(ids) then
		return ns.RegisterCallback(self, "GET_ITEM_INFO_RECEIVED")
	end

	C_Timer.After(1, Scan)
end


ns.RegisterCallback(ids, "_THIS_ADDON_LOADED", Scan)
ns.RegisterCallback(ids, "GET_ITEM_INFO_RECEIVED", OnItemInfoReceived)
