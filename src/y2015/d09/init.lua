---@type Mod201509
local lib = require "y2015.d09.lib"
local splitlines = require("pl.stringx").splitlines

---@type MainFunction
local function main(input)
	local lines = splitlines(input)
	print(lib.shortest(lines))
	print(lib.longest(lines))
end

return main


