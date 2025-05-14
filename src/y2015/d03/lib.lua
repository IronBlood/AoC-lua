---@param pos number[]
---@return string
local pos_to_string = function(pos)
	return table.concat(pos, ",")
end

---@param pos number[]
---@param c string
local update_pos = function(pos, c)
	local cases = {
		["^"] = function()
			pos[1] = pos[1] - 1
		end,
		["v"] = function()
			pos[1] = pos[1] + 1
		end,
		["<"] = function()
			pos[2] = pos[2] - 1
		end,
		[">"] = function()
			pos[2] = pos[2] + 1
		end,
	};

	(cases[c] or function() end)()
end

---@param set table
---@param pos number[]
---@param size number
local update_set = function(set, pos, size)
	local x = pos_to_string(pos)
	if not set[x] then
		set[x] = true
		size = size + 1
	end
	return size
end

---@class Mod201503
---@field count_horse fun(str: string): number
---@field count_horse_with_robo fun(str: string): number
return {
	count_horse = function(str)
		local pos = { 0, 0 }
		local set = {}
		local size = 0
		size = update_set(set, pos, size)

		for i = 1, #str do
			update_pos(pos, str:sub(i, i))
			size = update_set(set, pos, size)
		end
		return size
	end,
	count_horse_with_robo = function(str)
		local pos_santa = { 0, 0 }
		local pos_robo = { 0, 0 }
		local set = {}
		local size = 0
		size = update_set(set, pos_santa, size)
		for i = 1, #str, 2 do
			update_pos(pos_santa, str:sub(i, i))
			size = update_set(set, pos_santa, size)
			update_pos(pos_robo, str:sub(i + 1, i + 1))
			size = update_set(set, pos_robo, size)
		end
		return size
	end,
}
