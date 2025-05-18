local splitlines = require("pl.stringx").splitlines
local deepcopy = require("pl.tablex").deepcopy

---@param arr number[]
local function sum(arr)
	local acc = 0
	for _, v in pairs(arr) do
		acc = acc + v
	end
	return acc
end

---@param arr number[]
---@return number
local function mul(arr)
	local m = 1
	for _, v in pairs(arr) do
		m = m * v
	end
	return m
end

---@class Mod201524
---@field get_quantum fun(data: string, groups: number?): number
return {
	get_quantum = function(data, groups)
		groups = groups or 3
		---@type number[]
		local nums = {}
		for _, line in pairs(splitlines(data)) do
			nums[#nums + 1] = tonumber(line)
		end
		local weight = sum(nums) / groups
		table.sort(nums)

		---@type number[][]
		local candidates = {}

		---@param stack    number[]
		---@param curr_idx number
		---@param remain   number
		local function backtracking(stack, curr_idx, remain)
			if remain == 0 then
				table.insert(candidates, deepcopy(stack))
				return
			end

			for i = curr_idx, 1, -1 do
				if remain - nums[i] >= 0 then
					table.insert(stack, nums[i])
					backtracking(stack, i - 1, remain - nums[i])
					table.remove(stack)
				end
			end
		end
		backtracking({}, #nums, weight)

		table.sort(candidates, function(a, b)
			return #a < #b
		end)

		local final_stage, len = {}, #candidates[1]
		for _, v in ipairs(candidates) do
			if #v == len then
				final_stage[#final_stage + 1] = v
			end
		end

		local smallest = math.huge
		for _, x in ipairs(final_stage) do
			local m = mul(x)
			smallest = math.min(smallest, m)
		end
		return smallest
	end,
}
