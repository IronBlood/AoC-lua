---@type Mod201514
local lib = require("y2015.d14.lib")

local data = {
	"Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.",
	"Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.",
}

describe("2015-12-14 p1", function()
	local testcases = {
		{ 1, 16 },
		{ 10, 160 },
		{ 11, 176 },
		{ 12, 176 },
		{ 1000, 1120 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_equal(tc[2], lib.farthest(data, tc[1]))
		end)
	end
end)

describe("2015-12-14 p2", function()
	local testcases = {
		{ 1, 1 },
		{ 140, 139 },
		{ 1000, 689 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_equal(tc[2], lib.most_points(data, tc[1]))
		end)
	end
end)
