---@type Mod201506
local lib = require("y2015.d06.lib")

describe("2015-12-06 p1", function()
	local testcases = {
		-- stylua: ignore start
		{ "turn on 0,0 through 999,999",      { s = { 0, 0 }, e = { 999, 999 }, v = 1 } },
		{ "toggle 0,0 through 999,0",         { s = { 0, 0 }, e = { 999, 0 }, v = 2 } },
		{ "turn off 499,499 through 500,500", { s = { 499, 499 }, e = { 500, 500 }, v = 0 } },
		-- stylua: ignore end
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			local parsed = lib.parse(tc[1])
			assert.are_same(tc[2], parsed)
		end)
	end
end)
