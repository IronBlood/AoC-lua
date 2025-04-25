---@type Mod201504
local lib = require "y2015.d04.lib"

---@type MainModule
return {
	main = function (str)
		print(lib.mine_coin(str))
		print(lib.mine_coin(str, 6))
	end
}

