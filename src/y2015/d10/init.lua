---@type Mod201510
local lib = require "y2015.d10.lib"
local look_and_say = lib.look_and_say

---@param input string
---@param count number
---@param set   table
local function loop(input, count, set)
	local i = 0
	while i < count do
		input = look_and_say(input)
		i = i + 1
		if set[i] then
			print(#input)
		end
	end
	return input
end

---@type MainFunction
local function main(input)
	local set = {};
	set[40] = true
	set[50] = true
	loop(input, 50, set)
end

return main

