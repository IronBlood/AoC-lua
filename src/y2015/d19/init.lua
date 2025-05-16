---@type Mod201519
local lib = require("y2015.d19.lib")

---@type MainFunction
local function main(input)
	print(lib.possible_molecules(input))
	print(lib.reduce(input))
end

return main
