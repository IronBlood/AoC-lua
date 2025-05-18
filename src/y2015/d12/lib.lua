local cjson = require("cjson")
local is_array = require("utils.array").is_array

local function contains_red(tbl)
	if type(tbl) ~= "table" then
		return false
	end
	for _, v in pairs(tbl) do
		if v == "red" then
			return true
		end
	end
	return false
end

---@class Mod201512
---@field sum_numbers fun(json_str: string): number
---@field sum_numbers_exclude_red fun(json_str: string): number
return {
	sum_numbers = function(json_str)
		local obj = cjson.decode(json_str)
		local sum = 0

		local function dfs(jobj)
			if type(jobj) == "number" then
				sum = sum + jobj
			elseif type(jobj) == "table" then
				for _, v in pairs(jobj) do
					dfs(v)
				end
			end
		end

		dfs(obj)
		return math.floor(sum)
	end,
	sum_numbers_exclude_red = function(json_str)
		local function dfs(data)
			if type(data) == "number" then
				return data
			elseif type(data) == "table" then
				if not is_array(data) and contains_red(data) then
					return 0
				end

				local sum = 0
				for _, v in pairs(data) do
					sum = sum + dfs(v)
				end
				return sum
			end
			return 0
		end

		return math.floor(dfs(cjson.decode(json_str)))
	end,
}
