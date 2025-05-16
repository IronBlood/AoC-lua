---@type Mod201519
local lib = require("y2015.d19.lib")

describe("2015-12-19 p1", function()
	local testcases = {
		{ [[H => HO
H => OH
O => HH

HOH]], 4 },
		{ [[H => HO
H => OH
O => HH

HOHOHO]], 7 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[2], lib.possible_molecules(tc[1]))
		end)
	end
end)
