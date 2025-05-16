---@type Mod201520
local lib = require("y2015.d20.lib")

describe("2015-12-20 p1", function()
	local testcases = {
		{ 2, 30 },
		{ 3, 40 },
		{ 4, 70 },
		{ 5, 60 },
		{ 6, 120 },
		{ 7, 80 },
		{ 8, 150 },
		{ 9, 130 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[2], lib.count_presents_by_houseid(tc[1]))
		end)
	end
end)
