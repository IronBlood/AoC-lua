---@class Mod201505
local lib = require "y2015.d05.lib"
local splitlines = require("pl.stringx").splitlines
local reduce = require("pl.tablex").reduce

---@type MainModule
return {
	main = function(input)
		local lines = splitlines(input)
		print(reduce(function(acc, line)
			return acc + lib.is_nice(line)
		end, lines, 0))
		print(reduce(function(acc, line)
			return acc + lib.is_nice2(line)
		end, lines, 0))
	end
}

