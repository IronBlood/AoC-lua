local stringx = require("pl.stringx")

---@class Mod201523
---@field sim fun(data: string, part: number?): number[]
return {
	sim = function(data, part)
		part = part or 0
		local registers = { 0, 0 }
		if part == 1 then
			registers[1] = 1
		end

		local instructions = stringx.splitlines(data)
		local i = 1
		while i <= #instructions do
			local instruction = instructions[i]
			local code = instruction:sub(1, 3)
			local oprands = stringx.split(instruction:sub(5), ", ")
			local idx

			if code == "hlf" then
				idx = oprands[1] == "a" and 1 or 2
				registers[idx] = registers[idx] >> 1
			elseif  code == "tpl" then
				idx = oprands[1] == "a" and 1 or 2
				registers[idx] = registers[idx] * 3
			elseif code == "inc" then
				idx = oprands[1] == "a" and 1 or 2
				registers[idx] = registers[idx] + 1
			elseif code == "jmp" then
				i = i + (tonumber(oprands[1]) or 0)
				goto continue
			elseif code == "jie" then
				idx = oprands[1] == "a" and 1 or 2
				if (registers[idx] & 1) == 0 then
					i = i + (tonumber(oprands[2]) or 0)
					goto continue
				end
			elseif code == "jio" then
				idx = oprands[1] == "a" and 1 or 2
				if registers[idx] == 1 then
					i = i + (tonumber(oprands[2]) or 0)
					goto continue
				end
			end
			i = i + 1

		    ::continue::
		end

		return registers
	end,
}

