local stringx = require("pl.stringx")
local stringx_split = stringx.split
local stringx_count = stringx.count

---@param str string
---@return boolean
local function is_number(str)
	return str and not (str:match("[^0-9]") ~= nil)
end

---@class Expression
---@field key string
---@field opcode string?
---@field oprands (string|number)[]
---@field evaluated boolean
local Expression = {}

---@param cmd string
---@return Expression
local function parse(cmd)
	local arr = stringx_split(cmd, " -> ")
	local exp = arr[1]
	local key = arr[2]

	if stringx_count(exp, " ") == 0 then
		return {
			key = key,
			oprands = { is_number(exp) and tonumber(exp) or exp },
			opcode = "ASSIGN",
			evaluated = false,
		}
	end

	arr = stringx_split(exp, " ")
	if #arr == 2 then
		return {
			key = key,
			oprands = { is_number(arr[2]) and tonumber(arr[2]) or arr[2] },
			opcode = "NOT",
			evaluated = false,
		}
	end

	return {
		key = key,
		oprands = {
			is_number(arr[1]) and tonumber(arr[1]) or arr[1],
			is_number(arr[3]) and tonumber(arr[3]) or arr[3],
		},
		opcode = arr[2],
		evaluated = false,
	}
end

---@param values table
---@param oprands (string|number)[]
local function is_ready_to_evaluate(values, oprands)
	for i = 1, #oprands do
		local o = oprands[i]
		if type(o) == "number" then
			goto continue
		end

		if not values[o] then
			return false
		end

		::continue::
	end

	return true
end

---@param values table
---@param e Expression
local function evaluate(values, e)
	e.evaluated = true

	---@param input number|string
	---@return number
	local function get_value(input)
		return type(input) == "number" and input or values[input]
	end

	-- Lua 5.4
	local v
	if e.opcode == "ASSIGN" then
		v = get_value(e.oprands[1])
	elseif e.opcode == "NOT" then
		v = ~get_value(e.oprands[1])
	elseif e.opcode == "AND" then
		v = get_value(e.oprands[1]) & get_value(e.oprands[2])
	elseif e.opcode == "OR" then
		v = get_value(e.oprands[1]) | get_value(e.oprands[2])
	elseif e.opcode == "LSHIFT" then
		v = get_value(e.oprands[1]) << get_value(e.oprands[2])
	elseif e.opcode == "RSHIFT" then
		v = get_value(e.oprands[1]) >> get_value(e.oprands[2])
	else
	end

	values[e.key] = v & 0xffff
end

---@param lines string[]
---@return table
local function sim(lines, part)
	if not part then
		part = 1
	end

	---@type Expression[]
	local expressions = {}
	for i = 1, #lines do
		expressions[i] = parse(lines[i])
	end

	local ans = {}

	local evaluated = 0

	while true do
		evaluated = 0

		for i = 1, #expressions do
			local e = expressions[i]
			if e.evaluated then
				goto continue
			end

			if is_ready_to_evaluate(ans, e.oprands) then
				evaluate(ans, e)
				evaluated = evaluated + 1
			end

			::continue::
		end

		if evaluated == 0 then
			break
		end
	end

	if part == 2 then
		-- reset
		ans = {
			["b"] = ans["a"],
		}
		for i = 1, #expressions do
			local e = expressions[i]
			if e.key ~= "b" then
				e.evaluated = false
			end
		end

		-- evaluate again
		while true do
			evaluated = 0

			for i = 1, #expressions do
				local e = expressions[i]
				if e.evaluated then
					goto continue
				end

				if is_ready_to_evaluate(ans, e.oprands) then
					evaluate(ans, e)
					evaluated = evaluated + 1
				end

				::continue::
			end

			if evaluated == 0 then
				break
			end
		end
	end

	return ans
end

return sim
