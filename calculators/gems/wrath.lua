
local myname, ns = ...


local COBALT = 36909
local SARONITE = 36912
local TITANIUM = 36910
local TITANIUM_DUST = 46849
local GREEN_GEMS = {36917, 36929, 36920, 36932, 36923, 36926}
local BLUE_GEMS = {36918, 36930, 36921, 36933, 36924, 36927}
local PURPLE_GEMS = {36919, 36931, 36922, 36934, 36925, 36928}


local COBALT_GREEN_RATE = 90 / 200
local COBALT_BLUE_RATE = 3 / 200
local SARONITE_GREEN_RATE = 66 / 200
local SARONITE_BLUE_RATE = 10 / 200
local TITANIUM_GREEN_RATE = 60 / 200
local TITANIUM_BLUE_RATE = 10 / 200
local TITANIUM_PURPLE_RATE = 11 / 200
local TITANIUM_DUST_RATE = 23 / 200


ns.prospecting_funcs[COBALT] = function()
	return
		GREEN_GEMS, COBALT_GREEN_RATE,
		BLUE_GEMS,  COBALT_BLUE_RATE
end


ns.prospecting_funcs[SARONITE] = function()
	return
		GREEN_GEMS, SARONITE_GREEN_RATE,
		BLUE_GEMS,  SARONITE_BLUE_RATE
end


ns.prospecting_funcs[TITANIUM] = function()
	return
		GREEN_GEMS,  TITANIUM_GREEN_RATE,
		BLUE_GEMS,   TITANIUM_BLUE_RATE,
		PURPLE_GEMS, TITANIUM_PURPLE_RATE,
		TITANIUM_DUST, TITANIUM_DUST_RATE
end
