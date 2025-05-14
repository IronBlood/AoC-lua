---@type Mod201508
local lib = require("y2015.d08.lib")

describe("2015-12-08", function()
	local testcase = {
		'""',
		'"abc"',
		'"aaa\\"aaa"',
		'"\\x27"',
	}
	it("test-1", function()
		assert.are.same(12, lib.diff_decode(testcase))
	end)
	it("test-2", function()
		assert.are.same(19, lib.diff_encode(testcase))
	end)
end)
