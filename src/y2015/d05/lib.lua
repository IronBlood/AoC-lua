---@class Mod201505
---@field is_nice fun(str: string): number
---@field is_nice2 fun(str: string): number
return {
	is_nice = function(str)
		local count_vowel = 0
		for i = 1, #str do
			local c = str:sub(i, i)
			if c == "a" or c == "e" or c == "i" or c == "o" or c == "u" then
				count_vowel = count_vowel + 1
			end
			if count_vowel == 3 then
				break
			end
		end
		if count_vowel < 3 then
			return 0
		end

		for i = 1, #str-1 do
			local seg = str:sub(i, i+1)
			if seg == "ab" or seg == "cd" or seg == "pq" or seg == "xy" then
				return 0;
			end
		end

		for i = 1, #str-1 do
			if str:sub(i, i) == str:sub(i+1, i+1) then
				return 1
			end
		end

		return 0
	end,
	is_nice2 = function(str)
		local found = false
		for i = 1, #str-1, 1 do
			local seg = str:sub(i, i+1)
			if str:find(seg, i+2, true) then
				found = true
				break
			end
		end
		if not found then
			return 0
		end

		found = false
		for i = 2, #str-1 do
			if str:sub(i-1, i-1) == str:sub(i+1, i+1) then
				found = true
				break
			end
		end

		return found and 1 or 0
	end,
}

