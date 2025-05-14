---@type Mod201501
local lib = require("y2015.d01.lib")

describe("2015-12-01 p1", function()
	local testcases = {
		-- stylua: ignore start
		{ "(())",    0 },
		{ "(((",     3 },
		{ "(()(()(", 3 },
		{ "))(((((", 3 },
		{ "())",     -1 },
		{ "))(",     -1 },
		{ ")))",     -3 },
		{ ")())())", -3 },
		-- stylua: ignore end
	}

	for i, tc in ipairs(testcases) do
		local input, expected = tc[1], tc[2]
		it("test-" .. i, function()
			assert.are.equal(expected, lib.floor(input))
		end)
	end
end)

describe("2015-12-02 p2", function()
	local testcases = {
		{ ")", 1 },
		{ "()())", 5 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are.equal(lib.first_enter_basement(tc[1]), tc[2])
		end)
	end
end)
