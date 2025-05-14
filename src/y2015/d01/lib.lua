---@class Mod201501
---@field floor fun(str: string): number
---@field first_enter_basement fun(str: string): number
local M = {}

M.floor = function(str)
	local ans = 0
	for i = 1, #str do
		local c = str:sub(i, i)
		if c == "(" then
			ans = ans + 1
		else
			ans = ans - 1
		end
	end
	return ans
end

M.first_enter_basement = function(str)
	local ans = 0
	for i = 1, #str do
		if str:sub(i, i) == "(" then
			ans = ans + 1
		else
			ans = ans - 1
		end

		if ans < 0 then
			return i
		end
	end
	return -1
end

return M
