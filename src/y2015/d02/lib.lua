local split = require("pl.stringx").split
local map = require("pl.tablex").map
local min = math.min

---@class Mod201502
---@field total_square fun(str: string): number
---@field total_ribbon fun(str: string): number
local M = {}

M.total_square = function(str)
	local arr = map(tonumber, split(str, "x"))
	local area = 0
	local smallest = math.huge
	local tmp = 0

	for i = 1, 2 do
		for j = i + 1, 3 do
			tmp = arr[i] * arr[j]
			smallest = min(smallest, tmp)
			area = area + 2 * tmp
		end
	end

	return area + smallest
end

M.total_ribbon = function(str)
	local arr = split(str, "x")
	local arr_dup = {}
	for k, v in pairs(arr) do
		arr_dup[k] = tonumber(v)
	end
	table.sort(arr_dup)
	local a, b, c = arr_dup[1], arr_dup[2], arr_dup[3]
	return a * b * c + 2 * (a + b)
end

return M
