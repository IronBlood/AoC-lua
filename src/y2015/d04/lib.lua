local md5 = require("md5")
local startswith = require("pl.stringx").startswith

---@class Mod201504
---@field mine_coin fun(str: string, digit?: number): number
return {
	mine_coin = function(str, digit)
		if not digit or type(digit) ~= "number" then
			digit = 5
		end

		local targeting = ("0"):rep(digit)
		for i = 0, math.huge do
			local sum = md5.sumhexa(str .. tostring(i))
			if startswith(sum, targeting) then
				return i
			end
		end
		return -1
	end,
}
