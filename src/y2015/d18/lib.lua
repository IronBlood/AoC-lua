local splitlines = require("pl.stringx").splitlines

---@param grid string[][]
---@param x    number
---@param y    number
---@param rows number
---@param cols number
local function count_neighbors(grid, x, y, rows, cols)
	local count = 0
	-- stylua: ignore start
	local dirs = {
		{ -1, -1 }, { -1, 0 }, { -1, 1 },
		{  0, -1 },            {  0, 1 },
		{  1, -1 }, {  1, 0 }, {  1, 1 },
	}
	-- stylua: ignore end
	for _, d in pairs(dirs) do
		local a, b = x + d[1], y + d[2]
		if a >= 1 and b >= 1 and a <= rows and b <= cols and grid[a][b] == "#" then
			count = count + 1
		end
	end

	return count
end

---@param grid string[][]
---@param part number
---@return string[][]
local function iterate(grid, part)
	local rows, cols = #grid, #grid[1]
	local next = {}
	for i = 1, rows do
		local row = {}
		for j = 1, cols do
			local n = count_neighbors(grid, i, j, rows, cols)
			local c
			if grid[i][j] == "#" then
				c = (n == 2 or n == 3) and "#" or "."
			else
				c = n == 3 and "#" or "."
			end
			row[j] = c
		end
		next[i] = row
	end
	if part == 2 then
		-- stylua: ignore start
		next[1][1]       = "#"
		next[1][cols]    = "#"
		next[rows][1]    = "#"
		next[rows][cols] = "#"
		-- stylua: ignore end
	end
	return next
end

---@param grid string[][]
local function count(grid)
	local sum = 0
	for _, row in pairs(grid) do
		for _, cell in pairs(row) do
			if cell == "#" then
				sum = sum + 1
			end
		end
	end
	return sum
end

---@class Mod201518
---@field count_lights fun(data: string, steps: number, part: number?): number
return {
	count_lights = function(data, steps, part)
		part = part or 1
		local grid = {}
		for _, line in ipairs(splitlines(data)) do
			local row = {}
			for i = 1, #line do
				row[#row + 1] = line:sub(i, i)
			end
			grid[#grid + 1] = row
		end

		local i = 0
		while i < steps do
			grid = iterate(grid, part)
			i = i + 1
		end

		return count(grid)
	end,
}
