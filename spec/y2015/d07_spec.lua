local sim = require "y2015.d07.lib"

describe("2015-12-07 p1", function()
	local commands = {
		"123 -> x",
		"456 -> y",
		"x AND y -> d",
		"x OR y -> e",
		"x LSHIFT 2 -> f",
		"y RSHIFT 2 -> g",
		"NOT x -> h",
		"NOT y -> i",
	}

	it("test-1", function()
		local result = sim(commands)
		assert.are_equal(72,    result.d)
		assert.are_equal(507,   result.e)
		assert.are_equal(492,   result.f)
		assert.are_equal(114,   result.g)
		assert.are_equal(65412, result.h)
		assert.are_equal(65079, result.i)
		assert.are_equal(123,   result.x)
		assert.are_equal(456,   result.y)
	end)
end)

