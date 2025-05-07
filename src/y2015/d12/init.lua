---@type Mod201512
local lib = require "y2015.d12.lib"

---@type MainFunction
local function main(input)
	print(lib.sum_numbers(input))
	print(lib.sum_numbers_exclude_red(input))
end

return main

