---@type Mod201525
local lib = require("y2015.d25.lib")

---@type MainFunction
local function main(input)
	local row_str, col_str = input:match("row (%d+), column (%d+)")
	print(row_str, col_str)
	print(lib.get_code(tonumber(row_str) or 0, tonumber(col_str) or 0))
end

return main
