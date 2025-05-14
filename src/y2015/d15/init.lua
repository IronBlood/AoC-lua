---@type Mod201515
local lib = require("y2015.d15.lib")
local splitlines = require("pl.stringx").splitlines

---@type MainFunction
local function main(input)
	local lines = splitlines(input)
	print(lib.make_a_cookie(lines))
	print(lib.make_a_cookie_with_fixed_calorie(lines, 500))
end

return main
