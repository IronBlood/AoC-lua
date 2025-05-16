local byte = string.byte
local stringx = require("pl.stringx")
local size = require("pl.tablex").size
local split, splitlines = stringx.split, stringx.splitlines

-- Fisher–Yates (Knuth) shuffle
---@param tbl table
local function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(1, i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
end

---@param str string
local function split_molecue(str)
	---@type string[]
	local arr = {}
	local i, len = 1, #str
	while i <= len do
		local seg, d
		if (i + 1) <= len then
			local c = byte(str, i + 1)
			if c >= 97 and c <= 122 then
				seg = str:sub(i, i + 1)
				d = 2
			else
				seg = str:sub(i, i)
				d = 1
			end
		else
			seg = str:sub(i, i)
			d = 1
		end
		i = i + d
		arr[#arr + 1] = seg
	end
	return arr
end

---@param cfg string[]
local function gen_map(cfg)
	---@type table<string, string[]>
	local map = {}
	for _, line in pairs(cfg) do
		local arr = split(line, " => ")
		local s, t = arr[1], arr[2]
		if map[s] then
			table.insert(map[s], t)
		else
			map[s] = { t }
		end
	end
	return map
end

---@class Mod201519
---@field possible_molecules fun(data: string): number
---@field reduce fun(data: string): number
return {
	possible_molecules = function(data)
		local lines = splitlines(data)
		local target = table.remove(lines)
		-- the empty line
		table.remove(lines)

		local map = gen_map(lines)
		local elements = split_molecue(target)

		local set = {}

		for i = 1, #elements do
			local curr = elements[i]
			local candidates = map[curr]
			if not candidates then
				goto continue
			end
			for j = 1, #candidates do
				elements[i] = candidates[j]
				set[table.concat(elements)] = true
			end
			elements[i] = curr
			::continue::
		end

		return size(set)
	end,
	reduce = function(data)
		local arr = split(data, "\n\n")
		---@type string[][]
		local reduce_map = {}
		for _, line in pairs(splitlines(arr[1])) do
			reduce_map[#reduce_map+1] = split(line, " => ")
		end

		local mol, steps, count = arr[2], 0, 0

		while mol ~= "e" do
			-- dead end
			if count > 1000000 then
				print("unreachable")
				break
			end
			count = count + 1

			local prev = mol
			local sub_count
			for _, p in pairs(reduce_map) do
				local f, t = p[1], p[2]
				if not string.find(mol, t) then
					goto continue
				end
				mol, sub_count = string.gsub(mol, t, f)
				steps = steps + sub_count
				::continue::
			end

			-- if nothing changed in one iteration, shuffle the map
			-- and start over
			if mol == prev then
				shuffle(reduce_map)
				steps = 0
				mol = arr[2]
			end
		end
		return steps
	end,
}
