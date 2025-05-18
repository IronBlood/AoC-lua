---@type Mod201521
local lib = require("y2015.d21.lib")

---@type MainFunction
local function main(input)
	print(lib.eval(input, 1))
	print(lib.eval(input, 2))
end

return main
