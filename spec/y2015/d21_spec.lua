---@type Mod201521
local lib = require("y2015.d21.lib")

describe("2015-12-21 ut-WAR_parse", function()
	local WAR = lib.WAR
	local testcases = {
		{ 3, #WAR },
		{ "table", type(WAR[1]) },
		{ "table", type(WAR[2]) },
		{ "table", type(WAR[3]) },
		{ 5, #WAR[1] },
		{ 5, #WAR[2] },
		{ 6, #WAR[3] },
		{ "Greataxe", WAR[1][5].name },
		{ 74, WAR[1][5].cost },
		{ 8, WAR[1][5].damage },
		{ 0, WAR[1][5].armor },
		{ "Defense +3", WAR[3][6].name },
		{ 80, WAR[3][6].cost },
		{ 0, WAR[3][6].damage },
		{ 3, WAR[3][6].armor },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[1], tc[2])
		end)
	end
end)

describe("2015-12-21 ut-can_win", function()
	local testcases = {
		{
			{ hp = 8, damage = 5, armor = 5 },
			{ hp = 12, damage = 7, armor = 2 },
			true,
		},
		{
			{ hp = 100, damage = 4, armor = 0 },
			{ hp = 103, damage = 9, armor = 2 },
			false,
		},
		{
			{ hp = 100, damage = 9, armor = 2 },
			{ hp = 103, damage = 9, armor = 2 },
			true,
		},
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.can_win(tc[1], tc[2]))
		end)
	end
end)
