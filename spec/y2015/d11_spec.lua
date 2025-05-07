---@type Mod201511
local lib = require "y2015.d11.lib"

describe("2015-12-11 p1-is_valid", function ()
	local testcases = {
		{"hijklmmn", false},
		{"abbceffg", false},
		{"abbcegjk", false},
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function ()
			assert.are_same(tc[2], lib.is_valid(tc[1]))
		end)
	end
end)

