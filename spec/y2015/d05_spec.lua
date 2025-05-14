---@type Mod201505
local lib = require("y2015.d05.lib")

describe("2015-12-05 p1", function()
	local testcases = {
		-- stylua: ignore start
		{ "ugknbfddgicrmopn", 1 },
		{ "aaa",              1 },
		{ "jchzalrnumimnmhp", 0 },
		{ "haegwjzuvuyypxyu", 0 },
		{ "dvszwmarrgswjxmb", 0 },
		-- stylua: ignore end
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.is_true(type(lib.is_nice) == "function")
			assert.are_same(tc[2], lib.is_nice(tc[1]))
		end)
	end
end)

describe("2015-12-05 p2", function()
	local testcases = {
		-- stylua: ignore start
		{ "qjhvhtzxzqqjkmpb", 1 },
		{ "xxyxx",            1 },
		{ "uurcxstgmygtbstg", 0 },
		{ "ieodomkazucvgmuy", 0 },
		-- stylua: ignore end
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[2], lib.is_nice2(tc[1]))
		end)
	end
end)
