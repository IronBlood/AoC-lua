---@type Mod201524
local lib = require("y2015.d24.lib")

describe("2015-12-24", function()
	local testcases = {
		{ [[1
2
3
4
5
7
8
9
10
11]], 3, 99 },
		{ [[1
2
3
4
5
7
8
9
10
11]], 4, 44 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.get_quantum(tc[1], tc[2]))
		end)
	end
end)
