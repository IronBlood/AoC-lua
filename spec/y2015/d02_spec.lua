---@type Mod201502
local lib = require("y2015.d02.lib")

describe("2015-12-01", function()
	local testcases = {
		{ "2x3x4",  58, 34 },
		{ "1x1x10", 43, 14 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are.equal(tc[2], lib.total_square(tc[1]))
			assert.are.equal(tc[3], lib.total_ribbon(tc[1]))
		end)
	end
end)
