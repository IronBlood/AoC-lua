---@class Mod201520
---@field count_presents_by_houseid fun(id: number): number
---@field count_presents_by_houseid2 fun(id: number): number
return {
	count_presents_by_houseid = function(id)
		local sum = 0
		for i = 1, math.sqrt(id) do
			if (id % i) == 0 then
				sum = sum + i
				if i * i ~= id then
					sum = sum + id / i
				end
			end
		end
		return sum * 10
	end,
	count_presents_by_houseid2 = function(id)
		local sum = 0
		for i = 1, math.sqrt(id) do
			if id % i == 0 then
				if i * 50 >= id then
					sum = sum + i
				end
				local other = id / i
				if other ~= i and other * 50 >= id then
					sum = sum + other
				end
			end
		end
		return 11 * sum
	end,
}
