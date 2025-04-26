local sim = require "y2015.d07.lib"
local splitlines = require "pl.stringx".splitlines

---@type MainFunction
local function main(input)
	local lines = splitlines(input)
	print(sim(lines)["a"])
	print(sim(lines, 2)["a"])
end

return main

