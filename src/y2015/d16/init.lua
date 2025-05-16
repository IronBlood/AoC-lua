---@type Mod201516
local lib = require("y2015.d16.lib")

local targeting = [[children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1]]

---@type MainFunction
local function main(input)
	print(lib.find_aunt_sue(input, targeting))
	print(lib.find_aunt_sue(input, targeting, 2))
end

return main
