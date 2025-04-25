---@type Mod201503
local lib = require "y2015.d03.lib"

describe("2015-12-03 p1", function()
	local testcases = {
		{ ">",          2 },
		{ "^>v<",       4 },
		{ "^v^v^v^v^v", 2 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.is.same(tc[2], lib.count_horse(tc[1]))
		end)
	end
end)

describe("2015-12-03 p2", function()
	local testcases = {
		{ "^v",         3 },
		{ "^>v<",       3 },
		{ "^v^v^v^v^v", 11 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.is.same(tc[2], lib.count_horse_with_robo(tc[1]))
		end)
	end
end)

