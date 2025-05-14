local splitlines = require("pl.stringx").splitlines

---@type Mod201514
local lib = require("y2015.d14.lib")

---@type MainFunction
local function main(input)
	local lines = splitlines(input)
	print(lib.farthest(lines, 2503))
	print(lib.most_points(lines, 2503))
end

return main
