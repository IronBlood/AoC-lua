---@type Mod201510
local lib = require("y2015.d10.lib")

describe("2015-12-10 p1", function()
	local testcases = {
		-- stylua: ignore start
		{ "1",      "11" },
		{ "11",     "21" },
		{ "21",     "1211" },
		{ "1211",   "111221" },
		{ "111221", "312211" },
		-- stylua: ignore end
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[2], lib.look_and_say(tc[1]))
		end)
	end
end)
