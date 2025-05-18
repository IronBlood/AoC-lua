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

---@generic T: any
---@param tbl T[]
---@param cb fun(x: T): boolean
function M.some(tbl, cb)
	for _, entry in ipairs(tbl) do
		if cb(entry) then
			return true
		end
	end
	return false
end

return M
