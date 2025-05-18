---@type Mod201523
local lib = require("y2015.d23.lib")

describe("2015-12-23 p1", function()
	local testcases = {
		{ [[inc a
jio a, +2
tpl a
inc a]], 1, 2 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.sim(tc[1])[tc[2]])
		end)
	end
end)
