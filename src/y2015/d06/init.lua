---@type Mod201506
local lib = require "y2015.d06.lib"
local splitlines = require "pl.stringx".splitlines

---@type MainModule
return {
	main = function(input)
		local lines = splitlines(input)
		print(lib.count_lights(lines))
		print(lib.count_brightness(lines))
	end
}

