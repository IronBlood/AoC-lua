---@type Mod201525
local lib = require("y2015.d25.lib")

describe("2015-12-25 p1-gen_next_code", function()
	local testcases = {
		{ 20151125, 31916031 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[2], lib.get_next_code(tc[1]))
		end)
	end
end)

describe("2015-12-25 p1-gen_num_by_xy", function()
	local testcases = {
		{ 1, 1, 1 },
		{ 2, 2, 5 },
		{ 3, 4, 19 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.get_num_by_xy(tc[1], tc[2]))
		end)
	end
end)

describe("2015-12-25 p1-get_code", function()
	local testcases = {
		{ 2, 1, 31916031 },
		{ 2, 2, 21629792 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.get_code(tc[1], tc[2]))
		end)
	end
end)
