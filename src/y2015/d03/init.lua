---@type Mod201503
local lib = require "y2015.d03.lib"

---@type MainModule
return {
	main = function (str)
		print(lib.count_horse(str))
		print(lib.count_horse_with_robo(str))
	end
}

