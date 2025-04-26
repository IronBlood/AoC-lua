---@type Mod201504
local lib = require "y2015.d04.lib"

---@type MainFunction
local function main(input)
	print(lib.mine_coin(input))
	print(lib.mine_coin(input, 6))
end

return main

