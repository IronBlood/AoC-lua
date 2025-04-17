---@type Mod201501
local lib = require("y2015.d01.lib")

---@type MainModule
return {
	main = function(input)
		print(lib.floor(input))
		print(lib.first_enter_basement(input))
	end,
}

