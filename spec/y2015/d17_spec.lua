---@type Mod201517
local lib = require("y2015.d17.lib")

describe("2015-12-17", function()
	local testcases = {
		{
			containers = { 20, 15, 10, 5, 5 },
			total = 25,
			o1 = 4,
			o2 = 2,
		},
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc.o1, lib.fill_containers(tc.containers, tc.total))
			assert.are_same(tc.o2, lib.minimum(tc.containers, tc.total))
		end)
	end
end)
