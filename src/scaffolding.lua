local attributes = require "lfs".attributes

local function create_folder(year, day)
	local list = {
		string.format("src/y%s/d%s", year, day),
		string.format("spec/y%s", year),
	}
	for _,folder_path in pairs(list) do
		if not attributes(folder_path) then
			print("Creating folder " .. folder_path)
			os.execute("mkdir -p " .. folder_path)
		else
			print("Folder " .. folder_path .. " exists, skipping creation...")
		end
	end
end

---Create a file at `file_path` with `content`
---@param file_path string
---@param content string
local function create_file(file_path, content)
	if not attributes(file_path) then
		print("Creating " .. file_path)
		local file = io.open(file_path, "w")
		if file then
			file:write(content)
			file:close()
		end
	else
		print("Skipping " .. file_path)
	end
end

local function create_init(year, day)
	local file_path = string.format("src/y%s/d%s/init.lua", year, day)
	local init_header = string.format("---@type Mod%s%s\nlocal lib = require \"y%s.d%d.lib\"\n\n", year, day, year, day)
	local init_body = "---@type MainFunction\nlocal function main(input)\nend\n\nreturn main\n\n"
	local content = init_header .. init_body
	create_file(file_path, content)
end

local function create_lib(year, day)
	local file_path = string.format("src/y%s/d%s/lib.lua", year, day)
	local content = string.format("---@class Mod%s%s\nreturn {\n}\n\n", year, day)
	create_file(file_path, content)
end

local function create_test(year, day)
	local file_path = string.format("spec/y%s/d%s_spec.lua", year, day)
	local content = string.format("---@type Mod%s%s\nlocal lib = require \"y%s.d%d.lib\"\n\n", year, day, year, day)
	create_file(file_path, content)
end

---@param year string
---@param day  string
local function scaffolding(year, day)
	create_folder(year, day)
	create_init(year, day)
	create_lib(year, day)
	create_test(year, day)
end

return scaffolding

