local split = require "pl.stringx".split
local table_size = require "pl.tablex".size

---@alias AdjTable { [string]: { [string]: number } }

---@param adj AdjTable
---@param u string
---@param v string
---@param d number
local function add_to_adj(adj, u, v, d)
	if not adj[u] then
		adj[u] = {}
	end
	adj[u][v] = d
end

---@param lines string[]
---@param comp fun(a: number, b: number): number
---@param init number
---@return number
local function find_extreme_route_length(lines, comp, init)
	---@type AdjTable
	local adj = {}
	for i = 1, #lines do
		local arr = split(lines[i], " ")
		local distance = tonumber(arr[5]) or 0
		add_to_adj(adj, arr[1], arr[3], distance)
		add_to_adj(adj, arr[3], arr[1], distance)
	end

	local ans = init
	local adj_size = table_size(adj)

	---@param seen table
	---@param curr string
	---@param sum  number
	local function dfs(seen, curr, sum)
		if table_size(seen) == adj_size then
			ans = comp(ans, sum)
			return
		end

		for k, v in pairs(adj[curr]) do
			if not seen[k] then
				seen[k] = true
				dfs(seen, k, sum + v)
				seen[k] = nil
			end
		end
	end

	for city,_ in pairs(adj) do
		local seen = {}
		seen[city] = true
		dfs(seen, city, 0)
	end

	return ans
end

---@class Mod201509
---@field shortest fun(lines: string[]): number
---@field longest  fun(lines: string[]): number
return {
	shortest = function(lines)
		return find_extreme_route_length(lines, math.min, math.huge)
	end,

	longest = function(lines)
		return find_extreme_route_length(lines, math.max, 0)
	end,
}

