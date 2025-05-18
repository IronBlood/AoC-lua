---@type Mod201523
local lib = require("y2015.d23.lib")

---@type MainFunction
local function main(input)
	print(lib.sim(input)[2])
	print(lib.sim(input, 1)[2])
end

return main
