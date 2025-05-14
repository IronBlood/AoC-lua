local split = require("pl.stringx").split

---@class Reindeer
---@field speed number
---@field last  number
---@field rest  number

---@param reindeer Reindeer
---@param seconds number
local function get_distance(reindeer, seconds)
	local cycle = seconds // (reindeer.last + reindeer.rest)
	local distance = cycle * reindeer.speed * reindeer.last
	local remain = seconds - cycle * (reindeer.last + reindeer.rest)
	distance = distance + math.min(remain, reindeer.last) * reindeer.speed
	return distance
end

---@class Mod201514
---@field farthest fun(data: string[], seconds: number): number
---@field most_points fun(data: string[], seconds: number): number
return {
	farthest = function(data, seconds)
		local res = 0
		for _, d in ipairs(data) do
			local arr = split(d, " ")
			-- stylua: ignore start
			---@type Reindeer
			local reindeer = {
				speed = tonumber(arr[4])  or 0,
				last  = tonumber(arr[7])  or 0,
				rest  = tonumber(arr[14]) or 0,
			}
			-- stylua: ignore end
			res = math.max(res, get_distance(reindeer, seconds))
		end
		return res
	end,
	most_points = function(data, seconds)
		local reindeers = {}
		local scores = {}

		for _, d in ipairs(data) do
			local arr = split(d, " ")
			-- stylua: ignore start
			table.insert(reindeers, {
				speed = tonumber(arr[4])  or 0,
				last  = tonumber(arr[7])  or 0,
				rest  = tonumber(arr[14]) or 0,
			})
			-- stylua: ignore end
			table.insert(scores, 0)
		end

		for i = 1, seconds do
			local max = 0
			local distances = {}
			for j = 1, #reindeers do
				distances[j] = get_distance(reindeers[j], i)
				max = math.max(max, distances[j])
			end
			for j = 1, #reindeers do
				if max == distances[j] then
					scores[j] = scores[j] + 1
				end
			end
		end

		local max = 0
		for i = 1, #scores do
			max = math.max(max, scores[i])
		end
		return max
	end,
}
