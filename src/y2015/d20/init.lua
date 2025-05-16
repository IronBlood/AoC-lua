---@type Mod201520
local lib = require("y2015.d20.lib")

---@type MainFunction
local function main(input)
	local target = tonumber(input) or 0
	local id = 1

	while lib.count_presents_by_houseid(id) < target do
		id = id + 1
	end
	print(id)

	id = 1
	while lib.count_presents_by_houseid2(id) < target do
		id = id + 1
	end
	print(id)
end

return main
