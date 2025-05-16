---@class Mod201517
---@field fill_containers fun(containers: number[], total: number): number
---@field minimum fun(containers: number[], total: number): number
return {
	fill_containers = function(containers, total)
		table.sort(containers)
		local ans = 0

		local function backtracking(curr, remain)
			if remain < 0 then
				return
			end
			if remain == 0 then
				ans = ans + 1
				return
			end
			for j = curr + 1, #containers do
				backtracking(j, remain - containers[j])
			end
		end

		backtracking(0, total)

		return ans
	end,
	minimum = function(containers, total)
		table.sort(containers, function(a, b)
			return a > b
		end)

		local ans = #containers

		local function backtracking(stack, curr, remain)
			if remain < 0 then
				return
			end

			if remain == 0 then
				ans = math.min(ans, #stack)
				return
			end

			for j = curr + 1, #containers do
				stack[#stack + 1] = j
				backtracking(stack, j, remain - containers[j])
				table.remove(stack)
			end
		end

		backtracking({}, 0, total)

		return ans
	end,
}
