---@type Mod201509
local lib = require("y2015.d09.lib")

describe("2015-12-09", function()
	local lines = {
		"London to Dublin = 464",
		"London to Belfast = 518",
		"Dublin to Belfast = 141",
	}
	it("test-1", function()
		assert.are.same(605, lib.shortest(lines))
	end)
	it("test-2", function()
		assert.are.same(982, lib.longest(lines))
	end)
end)
