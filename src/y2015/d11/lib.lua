---@param text string
local function _text_to_bytes(text)
	---@type number[]
	local arr = {}
	for i = 1, 8 do
		arr[i] = text:byte(i) - 97
	end
	return arr
end

---@param bytes number[]
local function _bytes_to_text(bytes)
	local builder = {}

	for i = 1, #bytes do
		builder[i] = string.char(bytes[i] + 97)
	end

	return table.concat(builder)
end

local function is_ilo(x)
	-- i: 8, l: 11, o: 14
	return x == 8 or x == 11 or x == 14
end

---@param arr number[]
local function _is_valid(arr)
	local flag_inc_3 = false
	for i = 1, 6 do
		if arr[i] + 1 == arr[i + 1] and arr[i] + 2 == arr[i + 2] then
			flag_inc_3 = true
			break
		end
	end
	if not flag_inc_3 then
		return false
	end

	for i = 1, 8 do
		if is_ilo(arr[i]) then
			return false
		end
	end

	local same_count, i = 0, 1
	while i <= 7 do
		if arr[i] == arr[i + 1] then
			same_count = same_count + 1
			i = i + 2
		else
			i = i + 1
		end
	end

	return same_count >= 2
end

---@param arr number[]
local function _gen(arr)
	local has_ilo = false
	for i = 1, 8 do
		if is_ilo(arr[i]) then
			has_ilo = true
			arr[i] = arr[i] + 1
			for j = i + 1, 8 do
				arr[j] = 0
			end
			break
		end
	end
	if has_ilo then
		return
	end

	local carry = 1
	for i = 8, 1, -1 do
		arr[i] = arr[i] + carry
		if arr[i] == 26 then
			carry = 1
		else
			carry = 0
		end
		arr[i] = arr[i] % 26
		if is_ilo(arr[i]) then
			arr[i] = arr[i] + 1
			break
		end
		if carry == 0 then
			break
		end
	end
end

---@class Mod201511
---@field is_valid fun(text: string): boolean
---@field gen_next fun(text: string): string
return {
	is_valid = function(text)
		return _is_valid(_text_to_bytes(text))
	end,
	gen_next = function(text)
		local arr = _text_to_bytes(text)
		repeat
			_gen(arr)
		until _is_valid(arr)
		return _bytes_to_text(arr)
	end,
}
