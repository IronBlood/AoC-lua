---@meta
---@class UtilsArray
local M = {}

function M.is_array(tbl)
	if type(tbl) ~= "table" then
		return false
	end
	local count = 0
	for k, _ in pairs(tbl) do
		if type(k) ~= "number" then
			return false
		end
		if k <= 0 or k ~= math.floor(k) then
			return false
		end
		count = count + 1
	end
	return count == #tbl
end

return M
