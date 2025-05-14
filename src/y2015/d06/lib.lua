local split = require("pl.stringx").split

local function gen_grid()
	local grid = {}
	for i = 1, 1000 do
		grid[i] = {}
		for j = 1, 1000 do
			grid[i][j] = 0
		end
	end
	return grid
end

---@param xy string
---@return number[]
local function xy_helper(xy)
	local splitted = split(xy, ",")
	return {
		tonumber(splitted[1]),
		tonumber(splitted[2]),
	}
end

---@param cmd string
---@return { s: number[], e: number[], v: number }
local function parse(cmd)
	local arr = split(cmd, " ")
	local s, e, v
	if #arr == 4 then
		s = xy_helper(arr[2])
		e = xy_helper(arr[4])
		v = 2
	else
		s = xy_helper(arr[3])
		e = xy_helper(arr[5])
		v = arr[2] == "on" and 1 or 0
	end
	return {
		s = s,
		e = e,
		v = v,
	}
end

local function count_grid(grid)
	local count = 0
	for i = 1, 1000 do
		for j = 1, 1000 do
			count = count + grid[i][j]
		end
	end
	return count
end

---@class Mod201506
---@field parse fun(cmd: string): { s: number[], e: number[], v: number }
---@field count_lights fun(lines: string[]): number
---@field count_brightness fun(lines: string[]): number
return {
	parse = parse,
	count_lights = function(lines)
		local grid = gen_grid()
		for i = 1, #lines do
			local parsed = parse(lines[i])
			for j = parsed.s[1] + 1, parsed.e[1] + 1 do
				for k = parsed.s[2] + 1, parsed.e[2] + 1 do
					if parsed.v == 2 then
						grid[j][k] = 1 - grid[j][k]
					else
						grid[j][k] = parsed.v
					end
				end
			end
		end

		return count_grid(grid)
	end,
	count_brightness = function(lines)
		local grid = gen_grid()
		for i = 1, #lines do
			local parsed = parse(lines[i])
			for j = parsed.s[1] + 1, parsed.e[1] + 1 do
				for k = parsed.s[2] + 1, parsed.e[2] + 1 do
					if parsed.v == 0 then
						grid[j][k] = math.max(grid[j][k] - 1, 0)
					elseif parsed.v == 1 then
						grid[j][k] = grid[j][k] + 1
					else
						grid[j][k] = grid[j][k] + 2
					end
				end
			end
		end

		return count_grid(grid)
	end,
}
