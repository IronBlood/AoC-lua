local splitlines = require("pl.stringx").splitlines

---@type Mod201517
local lib = require("y2015.d17.lib")

---@type MainFunction
local function main(input)
	local containers = {}
	for _, line in pairs(splitlines(input)) do
		containers[#containers + 1] = tonumber(line)
	end
	print(lib.fill_containers(containers, 150))
	print(lib.minimum(containers, 150))
end

return main
