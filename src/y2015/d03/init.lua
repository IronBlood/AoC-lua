---@type Mod201503
local lib = require("y2015.d03.lib")

---@type MainFunction
local function main(input)
	print(lib.count_horse(input))
	print(lib.count_horse_with_robo(input))
end

return main
