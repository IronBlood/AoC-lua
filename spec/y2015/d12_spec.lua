---@type Mod201512
local lib = require "y2015.d12.lib"

describe("2015-10-12 p1", function ()
	local testcases = {
		{'[1,2,3]', 6},
		{'{"a":2,"b":4}', 6},
		{'{"a":{"b":4},"c":-1}', 3},
		{'[]', 0},
		{'{}', 0},
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function ()
			assert.are_same(tc[2], lib.sum_numbers(tc[1]))
		end)
	end
end)

describe("2015-10-12 p2", function ()
	local testcases = {
		{'[1,2,3]', 6},
		{'[1,{"c":"red","b":2},3]', 4},
		{'{"d":"red","e":[1,2,3,4],"f":5}', 0},
		{'[1,"red",5]', 6},
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function ()
			assert.are_same(tc[2], lib.sum_numbers_exclude_red(tc[1]))
		end)
	end
end)

