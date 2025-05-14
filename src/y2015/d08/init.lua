---@type Mod201508
local lib = require("y2015.d08.lib")
local splitlines = require("pl.stringx").splitlines

local function main(input)
	local lines = splitlines(input)
	print(lib.diff_decode(lines))
	print(lib.diff_encode(lines))
end

return main
