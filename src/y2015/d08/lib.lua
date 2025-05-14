local reduce = require("pl.tablex").reduce

---@param line string
---@return number
local function real_len(line)
	local count = 0
	local i, l = 2, #line
	while i < l do
		local c = line:sub(i, i)
		if c == "\\" then
			local c1 = line:sub(i + 1, i + 1)
			if c1 == "x" then
				count = count + 1
				i = i + 4
			else
				count = count + 1
				i = i + 2
			end
		else
			count = count + 1
			i = i + 1
		end
	end
	return count
end

---@param line string
---@return number
local function encode_len(line)
	local len = 6
	for i = 2, #line - 1 do
		local c = line:sub(i, i)
		if c == "\\" or c == '"' then
			len = len + 2
		else
			len = len + 1
		end
	end
	return len
end

---@class Mod201508
---@field diff_decode fun(lines: string[]): number
---@field diff_encode fun(lines: string[]): number
return {
	diff_decode = function(lines)
		return reduce(function(acc, curr)
			return acc + #curr - real_len(curr)
		end, lines, 0)
	end,
	diff_encode = function(lines)
		return reduce(function(acc, curr)
			return acc + encode_len(curr) - #curr
		end, lines, 0)
	end,
}
