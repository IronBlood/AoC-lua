---@class Mod201510
---@field look_and_say fun(num: string): string
return {
	look_and_say = function(num)
		local builder = {}
		local i = 1
		local len = #num
		while i <= len do
			local j = i + 1
			while j <= len and num:sub(i, i) == num:sub(j, j) do
				j = j + 1
			end
			table.insert(builder, string.format("%d%s", j - i, num:sub(i, i)))
			i = j
		end
		return table.concat(builder)
	end,
}

