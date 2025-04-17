local splitlines = require("pl.stringx").splitlines
local reduce = require("pl.tablex").reduce
---@type Mod201502
local lib = require("y2015.d02.lib")

---@type MainModule
return {
	main = function(input)
		local lines = splitlines(input)

		print(reduce(function (acc, line)
			return acc + lib.total_square(line)
		end, lines, 0))

		print(reduce(function (acc, line)
			return acc + lib.total_ribbon(line)
		end, lines, 0))
	end,
}

