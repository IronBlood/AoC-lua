local stringx = require("pl.stringx")
local split = stringx.split
local splitlines = stringx.splitlines
local table_size = require("pl.tablex").size

---@class Mod201513
---@field arrange fun(data: string, part: number?): number
return {
	arrange = function(data, part)
		part = part or 1

		local name_to_id = {}
		local id = 0

		local raw_lines = splitlines(data)
		local lines = {}
		for _, l in ipairs(raw_lines) do
			table.insert(lines, l:sub(1, -2))
		end

		for i = 1, #lines do
			local arr = split(lines[i], " ")
			local names = {
				arr[1],
				arr[#arr],
			}
			for _, name in pairs(names) do
				if not name_to_id[name] then
					-- important, increasing id first in Lua
					id = id + 1
					name_to_id[name] = id
				end
			end
		end

		-- Create adjacency table
		local grid = {}
		for i = 1, id do
			grid[i] = {}
			for j = 1, id do
				grid[i][j] = 0
			end
		end
		for i = 1, #lines do
			local arr = split(lines[i], " ")
			local u = name_to_id[arr[1]]
			local v = name_to_id[arr[#arr]]
			local score = tonumber(arr[4])
			grid[u][v] = arr[3] == "lose" and -score or score
		end

		local ans = -math.huge

		---@param seats number[]
		---@return number
		local calc_part1 = function(seats)
			local sum = 0
			for i = 1, #seats - 1 do
				local a, b = seats[i], seats[i + 1]
				sum = sum + grid[a][b] + grid[b][a]
			end
			local s, e = seats[1], seats[#seats]
			sum = sum + grid[s][e] + grid[e][s]
			return sum
		end
		---@param seats number[]
		---@return number
		local calc_part2 = function(seats)
			local sum = 0
			for i = 1, #seats - 1 do
				local a, b = seats[i], seats[i + 1]
				sum = sum + grid[a][b] + grid[b][a]
			end
			return sum
		end

		local calc = part == 1 and calc_part1 or calc_part2

		---@param seats number[]
		---@param candidates number[]
		---@param seen table
		local function backtracking(seats, candidates, seen)
			if table_size(seen) == #candidates then
				ans = math.max(ans, calc(seats))
			else
				for i = 1, #candidates do
					if seen[i] then
						goto continue
					end

					table.insert(seats, candidates[i])
					seen[i] = true
					backtracking(seats, candidates, seen)
					seen[i] = nil
					table.remove(seats)
					::continue::
				end
			end
		end

		local candidates = {}
		if part == 1 then
			for i = 2, id do
				table.insert(candidates, i)
			end
			backtracking({ 1 }, candidates, {})
		else
			for i = 1, id do
				table.insert(candidates, i)
			end
			backtracking({}, candidates, {})
		end

		return ans
	end,
}
