---@type Mod201511
local lib = require("y2015.d11.lib")

---@type MainFunction
local function main(input)
	local password = input

	-- part 1
	password = lib.gen_next(password)
	print(password)

	-- part 2
	password = lib.gen_next(password)
	print(password)
end

return main
