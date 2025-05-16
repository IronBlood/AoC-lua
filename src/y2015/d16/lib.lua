local stringx = require("pl.stringx")
local split, splitlines = stringx.split, stringx.splitlines

---@type fun(data: string, targeting: string, part: number?): number?
local function find_aunt_sue(data, targeting, part)
	part = part or 1
	local lines = splitlines(data)
	local map = {}
	for _, line in pairs(splitlines(targeting)) do
		local arr = split(line, ": ")
		map[arr[1]] = tonumber(arr[2]) or 0
	end

	local candidate = {}
	local pattern = "^Sue (%d+): (.+)$"
	local count = 0
	for _, line in pairs(lines) do
		count = count + 1
		local id, attrStr = line:match(pattern)
		id = tonumber(id) or 0
		local attr = {}
		local keys = {}
		for _, a in pairs(split(attrStr, ", ")) do
			local x = split(a, ": ")
			attr[x[1]] = tonumber(x[2]) or 0
			keys[#keys + 1] = x[1]
		end

		local found = true
		for _, key in pairs(keys) do
			if part == 1 then
				if map[key] and map[key] ~= attr[key] then
					found = false
					break
				end
			else
				if map[key] then
					local value = map[key]
					if key == "cats" or key == "trees" then
						if attr[key] <= value then
							found = false
							break
						end
					elseif key == "pomeranians" or key == "goldfish" then
						if attr[key] >= value then
							found = false
							break
						end
					elseif attr[key] ~= value then
						found = false
						break
					end
				end
			end
		end
		if found then
			candidate[#candidate + 1] = {
				id = id,
				attr = attr,
			}
		end
	end
	return #candidate == 1 and candidate[1].id or nil
end

---@class Mod201516
---@field find_aunt_sue fun(data: string, targeting: string, part: number?): number
return {
	find_aunt_sue = find_aunt_sue,
}
