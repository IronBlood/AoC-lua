---@param code number
local function get_next_code(code)
	return (code * 252533) % 33554393
end

---@param x number
---@param y number
local function get_num_by_xy(x, y)
	local starting = (x + y - 1) * (x + y - 2) / 2 + 1
	return starting + y - 1
end

---@class Mod201525
---@field get_code fun(row: number, col: number): number
---@field get_next_code function
---@field get_num_by_xy function
return {
	get_next_code = get_next_code,
	get_num_by_xy = get_num_by_xy,
	get_code = function(row, col)
		local count = get_num_by_xy(row, col)
		local code = 20151125
		while true do
			count = count - 1
			if count <= 0 then
				break
			end
			code = get_next_code(code)
		end
		return code
	end,
}
