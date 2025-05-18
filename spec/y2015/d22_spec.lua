---@type Mod201522
local lib = require("y2015.d22.lib")

describe("2015-12-21 p1", function()
	local testcases = {
		{ { hp = 10, mana = 250 }, { hp = 13, damage = 8 }, 226 },
		{ { hp = 10, mana = 250 }, { hp = 14, damage = 8 }, 641 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.least_mana(tc[1], tc[2]))
		end)
	end
end)
