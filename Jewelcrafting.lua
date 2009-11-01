﻿
local de_values, de_means = PANDATAGS_DE_VALS, PANDATAGS_DE_VALS2
PANDATAGS_DE_VALS, PANDATAGS_DE_VALS2 = nil

local BC_GREEN_GEMS = {23077, 21929, 23112, 23079, 23117, 23107}
local BC_BLUE_GEMS = {23436, 23439, 23440, 23437, 23438, 23441}
local WRATH_GREEN_GEMS = {36917, 36929, 36920, 36932, 36923, 36926}
local WRATH_BLUE_GEMS = {36918, 36930, 36921, 36933, 36924, 36927}
local WRATH_PURPLE_GEMS = {36919, 36931, 36922, 36934, 36925, 36928}
local CUTS = {
	[23077] = {23094, 23095, 23097, 23096, 28595},
	[21929] = {23098, 23099, 23100, 23101, 31866, 31869},
	[23112] = {23113, 23114, 23115, 23116, 28290, 31860},
	[23079] = {23103, 23104, 23105, 23106},
	[23117] = {23118, 23119, 23120, 23121},
	[23107] = {23108, 23109, 23110, 23111, 31862, 31864},
	[23436] = {24027, 24028, 24029, 24030, 24031, 24032, 24036},
	[23439] = {24058, 24059, 24060, 24061, 31867, 31868, 35316},
	[23440] = {24047, 24048, 24050, 24051, 24052, 24053, 31861, 35315},
	[23437] = {24062, 24065, 24066, 24067, 33782, 35318},
	[23438] = {24033, 24035, 24037, 24039},
	[23441] = {24054, 24055, 24056, 24057, 31863, 31865, 35707},
	[24478] = {32833},
	[24479] = {32836},
	[25867] = {25896, 25897, 25898, 25899, 25901, 32409, 35501},
	[25868] = {25890, 25893, 25894, 25895, 32410, 34220, 35503},
	[32227] = {32193, 32194, 32195, 32196, 32197, 32198, 32199},
	[32231] = {32217, 32218, 32219, 32220, 32221, 32222, 35760},
	[32229] = {32204, 32205, 32206, 32207, 32208, 32209, 32210, 35761},
	[32249] = {32223, 32224, 32225, 32226, 35758, 35759},
	[32228] = {32200, 32201, 32202, 32203},
	[32230] = {32211, 32212, 32213, 32214, 32215, 32216},
	[36917] = {39900, 39905, 39906, 39907, 39908, 39909, 39910, 39911},
	[36929] = {39946, 39947, 39948, 39949, 39950, 39951, 39952, 39953, 39954, 39955, 39956, 39957, 39958, 39959, 39960, 39961, 39962, 39963, 39964, 39965, 39966, 39967},
	[36920] = {39912, 39914, 39915, 39916, 39917, 39918},
	[36932] = {39982, 39968, 39974, 39975, 39976, 39977, 39978, 39979, 39980, 39981, 39983, 39984, 39985, 39986, 39988, 39989, 39990, 39991, 39992},
	[36923] = {39919, 39920, 39927, 39932},
	[36926] = {39933, 39934, 39935, 39936, 39937, 39938, 39939, 39940, 39941, 39942, 39943, 39944, 39945},
	[36918] = {39996, 39997, 39998, 39999, 40000, 40001, 40002, 40003},
  [36930] = {40037, 40038, 40039, 40040, 40041, 40043, 40044, 40045, 40046, 40047, 40048, 40049, 40050, 40051, 40052, 40053, 40054, 40055, 40056, 40057, 40058, 40059},
  [36921] = {40012, 40016, 40017, 40014, 40013, 40015},
  [36933] = {40085, 40086, 40088, 40089, 40090, 40091, 40092, 40094, 40095, 40096, 40098, 40099, 40100, 40101, 40102, 40103, 40104, 40105, 40106},
  [36924] = {40008, 40009, 40010, 40011},
  [36927] = {40022, 40023, 40024, 40025, 40026, 40027, 40028, 40029, 40030, 40031, 40032, 40033, 40034},
	[36919] = {40111, 40112, 40113, 40115, 40116, 40117, 40118, 40118},
	[36931] = {40142, 40143, 40144, 40145, 40146, 40147, 40148, 40149, 40150, 40151, 40152, 40153, 40154, 40155, 40156, 40157, 40158, 40159, 40160, 40161, 40162, 40163},
	[36922] = {40123, 40124, 40125, 40126, 40127, 40128},
	[36934] = {40164, 40165, 40166, 40167, 40168, 40169, 40170, 40171, 40172, 40173, 40174, 40175, 40176, 40177, 40178, 40179},
	[36925] = {40119, 40120, 40121, 40122},
	[36928] = {40129, 40130, 40131, 40132, 40133, 40134, 40135, 40136, 40137, 40138, 40139, 40140, 40141, 40180, 40181, 40182},
}

local function GS(cash)
	if not cash then return end
	if cash > 999999 then return "|cffffd700".. floor(cash/10000) end

	cash = cash/100
	local s = floor(cash%100)
	local g = floor(cash/100)
	if g > 0 then return string.format("|cffffd700%d.|cffc7c7cf%02d", g, s)
	else return string.format("|cffc7c7cf%d", s) end
end


local values = setmetatable({}, {
	__index = function(t, link)
		if not link then return end
		local id = tonumber((link:match("item:(%d+):")))
		if not id or not CUTS[id] or not GetAuctionBuyout(id) then return end

		local val, count = 0, 0
		for _,cutid in pairs(CUTS[id]) do
			local sell = GetAuctionBuyout(cutid)
			if sell and sell > 0 then val, count = val + sell, count + 1 end
		end
		if count > 0 then
			val = string.format("%s |cffffffff(%.2f%% profit)", GS(val/count), ((val/count)/GetAuctionBuyout(id) - 1) * 100)
			t[link] = val
			return val
		end
	end,
})


local function gemavg(gems)
	local sum, skipped = 0, 0

	for _,id in pairs(gems) do
		local price = GetAuctionBuyout(id)
		if price and price > 0 then sum = sum + price else skipped = skipped + 1 end
	end

	return skipped < 6 and sum/(6 - skipped) or 0
end


local greengemDEvalue
local function greengemDE()
	-- All gems but green and purple have a 1 gem, 2 crystal earth recipe that can be DE'd
	-- 2x green + 2x purple + Eternal Earth == Jade Dagger Pendant (DE to a dream shard)
	if not greengemDEvalue then
		local ROYB_DE = GetAuctionBuyout(34054) * 0.75 * 2 + GetAuctionBuyout(34056) * 0.22 * 1.5 + GetAuctionBuyout(34053) * 0.03
		local GP_DE = GetAuctionBuyout(34052)
		local cryst_earth = math.min(GetAuctionBuyout(37701), GetAuctionBuyout(35624)/10)
		greengemDEvalue = (ROYB_DE + GP_DE - cryst_earth*12)/4
	end
	return greengemDEvalue
end


local origs = {}
local FEL_IRON_GREEN_RATE, FEL_IRON_BLUE_RATE = 1.027, 0.060
local ADAMANTITE_GREEN_RATE, ADAMANTITE_BLUE_RATE = 1.100, 0.195
local COBALT_GREEN_RATE, COBALT_BLUE_RATE = 1.5*1.5, 0.074
local SARONITE_GREEN_RATE, SARONITE_BLUE_RATE = 1.1*1.5, .24
local TITANIUM_GREEN_RATE, TITANIUM_BLUE_RATE, TITANIUM_PURPLE_RATE, TITANIUM_DUST_RATE = 1.5, 0.25, 0.27, 0.58
local OnTooltipSetItem = function(frame, ...)
	assert(frame, "arg 1 is nil, someone isn't hooking correctly")

	local _, link = frame:GetItem()
	if link then
		local val = values[link]
		if val and val ~= 0 then
			frame:AddDoubleLine("Average cut value:", val)
		else
			local id = tonumber((link:match("item:(%d+):")))

			local val = 0
			if     id == 23424 then val = (gemavg(BC_GREEN_GEMS)  *   FEL_IRON_GREEN_RATE + gemavg(BC_BLUE_GEMS) *    FEL_IRON_BLUE_RATE) * 4
			elseif id == 23425 then val = (gemavg(BC_GREEN_GEMS)  * ADAMANTITE_GREEN_RATE + gemavg(BC_BLUE_GEMS) *  ADAMANTITE_BLUE_RATE + 2250) * 4
			elseif id == 36909 then val = (gemavg(WRATH_GREEN_GEMS) *   COBALT_GREEN_RATE + gemavg(WRATH_BLUE_GEMS) *   COBALT_BLUE_RATE) * 4
			elseif id == 36912 then val = (gemavg(WRATH_GREEN_GEMS) * SARONITE_GREEN_RATE + gemavg(WRATH_BLUE_GEMS) * SARONITE_BLUE_RATE) * 4
			elseif id == 36910 then val = (gemavg(WRATH_GREEN_GEMS) * TITANIUM_GREEN_RATE + gemavg(WRATH_BLUE_GEMS) * TITANIUM_BLUE_RATE + gemavg(WRATH_PURPLE_GEMS) * TITANIUM_PURPLE_RATE + GetAuctionBuyout(46849) * TITANIUM_DUST_RATE) * 4 end

			local deval = 0
			if     id == 36909 then deval = (greengemDE() *   COBALT_GREEN_RATE + gemavg(WRATH_BLUE_GEMS) *   COBALT_BLUE_RATE)/5
			elseif id == 36912 then deval = (greengemDE() * SARONITE_GREEN_RATE + gemavg(WRATH_BLUE_GEMS) * SARONITE_BLUE_RATE)/5
			elseif id == 36910 then deval = (greengemDE() * TITANIUM_GREEN_RATE + gemavg(WRATH_BLUE_GEMS) * TITANIUM_BLUE_RATE + gemavg(WRATH_PURPLE_GEMS) * TITANIUM_PURPLE_RATE  + GetAuctionBuyout(46849) * TITANIUM_DUST_RATE)/5 end

			if val and val ~= 0 then frame:AddDoubleLine("Average crush value:", GS(val/20).."|cffffffff/ea - "..GS(val).."|cffffffff/stk") end
			if deval and deval ~= 0 then frame:AddDoubleLine("Crush & DE value:", GS(deval).."|cffffffff/ea") end

			if id == 44943 then
				local val = gemavg(WRATH_BLUE_GEMS) * 2.600 + (GetAuctionBuyout(42225) or 0) * 0.10
				frame:AddDoubleLine("Average value of contents:", GS(val).."|cffffffff/ea")
			end
		end
	end
	if origs[frame] then return origs[frame](frame, ...) end
end

for i,frame in pairs{GameTooltip, ItemRefTooltip} do
	origs[frame] = frame:GetScript("OnTooltipSetItem")
	frame:SetScript("OnTooltipSetItem", OnTooltipSetItem)
end


local f = CreateFrame("Frame")
f:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")
f:SetScript("OnEvent", function() for i in pairs(values) do values[i] = nil end; greengemDEvalue = nil end)