---@type Mod201515
local lib = require("y2015.d15.lib")

describe("2015-12-15", function()
	local recipes = {
		"Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8",
		"Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3",
	}
	it("test-0", function()
		assert.are_same(62842880, lib.make_a_cookie(recipes))
	end)
	it("test-1", function()
		assert.are_same(57600000, lib.make_a_cookie_with_fixed_calorie(recipes, 500))
	end)
end)
