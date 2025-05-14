-- To check version of Lua interpreter
-- print(_VERSION)

if #arg < 1 then
	print("Usage: lx run <year>-<day>")
	print("       for example, lx run 2015-01")
	print("Or, if you need to initialize source code and test file")
	print("for a new day, use this command instead")
	print("       lx run <year>-<day> s")
	os.exit(0)
end

--
-- Validate arg[1]
--

local year, day = string.match(arg[1], "^(%d%d%d%d)-(%d%d)$")
if not (year and day) then
	print("Invalid format. Expected input like '2015-01'.")
	os.exit(0)
end

local yearNum = tonumber(year)
local dayNum = tonumber(day)
if yearNum < 2015 or yearNum > 2024 then
	print("Year must be between 2015 and 2024")
	os.exit(0)
end
if dayNum < 1 or dayNum > 25 then
	print("Day must be between 01 and 25")
	os.exit(0)
end

if arg[2] == "scaffolding" or arg[2] == "s" then
	local scaffolding = require("scaffolding")
	scaffolding(year, day)
	os.exit(0)
end

--
-- Check and read input.txt, then trim the ending "\n"
--

local folderPath = string.format("src/y%s/d%s", year, day)
local inputFilePath = folderPath .. "/input.txt"
local file, err = io.open(inputFilePath, "r")
local inputData
if not file then
	print("Cannot open input file at '" .. inputFilePath .. "': " .. (err or "unknown error"))
	os.exit(0)
else
	---@type string
	inputData = file:read("*a"):gsub("\n$", "")
	file:close()
end

--
-- Load module
--

local fullModulePath = string.format("y%s.d%s", year, day)
local ok, main = pcall(require, fullModulePath)
if not ok then
	print("Module not found")
	os.exit(0)
end

--
-- Invoke the main function
--

if type(main) == "function" then
	---@cast main MainFunction
	main(inputData)
else
	print("Module doesn't return a callable 'main' function")
end
