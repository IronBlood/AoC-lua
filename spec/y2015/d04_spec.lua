---@type Mod201504
local lib = require("y2015.d04.lib")

describe("2015-12-04 p1", function()
	local testcases = {
		-- stylua: ignore start
		{ "abcdef",   609043 },
		{ "pqrstuv", 1048970 },
		-- stylua: ignore end
	}
	--- with `SKIP_MD5=true lx test`, these tests will be ignored
	local skip_md5 = os.getenv("SKIP_MD5")
	if not skip_md5 then
		for i, tc in ipairs(testcases) do
			it("test-" .. i, function()
				assert.is.same(tc[2], lib.mine_coin(tc[1]))
			end)
		end
	end
end)
