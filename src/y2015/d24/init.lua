---@type Mod201524
local lib = require("y2015.d24.lib")

---@type MainFunction
local function main(input)
	print(lib.get_quantum(input))
	print(lib.get_quantum(input, 4))
end

return main
