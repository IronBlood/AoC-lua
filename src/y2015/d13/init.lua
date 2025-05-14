---@type Mod201513
local lib = require("y2015.d13.lib")

---@type MainFunction
local function main(input)
	print(lib.arrange(input))
	print(lib.arrange(input, 2))
end

return main
