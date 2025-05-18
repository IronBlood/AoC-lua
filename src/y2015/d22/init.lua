---@type Mod201522
local lib = require("y2015.d22.lib")
local stringx = require("pl.stringx")

---@type MainFunction
local function main(input)
	local lines = stringx.splitlines(input)
	local b_hp = tonumber(stringx.split(lines[1], ": ")[2]) or 0
	local b_d = tonumber(stringx.split(lines[2], ": ")[2]) or 0

	print(lib.least_mana({ hp = 50, mana = 500 }, { hp = b_hp, damage = b_d }))
	print(lib.least_mana({ hp = 50, mana = 500 }, { hp = b_hp, damage = b_d }, 2))
end

return main
