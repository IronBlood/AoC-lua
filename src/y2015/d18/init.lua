---@type Mod201518
local lib = require("y2015.d18.lib")

---@type MainFunction
local function main(input)
	print(lib.count_lights(input, 100))
	print(lib.count_lights(input, 100, 2))
end

return main
