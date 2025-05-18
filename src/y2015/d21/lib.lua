local stringx = require("pl.stringx")

-- ==================
--    Parse Items
-- ==================
local config = stringx.strip([[
Weapons:    Cost  Damage  Armor
Dagger        8     4       0
Shortsword   10     5       0
Warhammer    25     6       0
Longsword    40     7       0
Greataxe     74     8       0

Armor:      Cost  Damage  Armor
Leather      13     0       1
Chainmail    31     0       2
Splintmail   53     0       3
Bandedmail   75     0       4
Platemail   102     0       5

Rings:      Cost  Damage  Armor
Damage +1    25     1       0
Damage +2    50     2       0
Damage +3   100     3       0
Defense +1   20     0       1
Defense +2   40     0       2
Defense +3   80     0       3
]])

---@class WARItem
---@field name   string
---@field cost   number
---@field damage number
---@field armor  number

---@param line string
---@return WARItem
local function parse_line(line)
	local name, a, b, c = line:match("^(.-)%s+(%d+)%s+(%d+)%s+(%d+)$")
	name = name:match("^(.-)%s*$")
	return {
		name = name,
		cost = tonumber(a),
		damage = tonumber(b),
		armor = tonumber(c),
	}
end

---@param seg string
local function parse_segment(seg)
	local lines = stringx.splitlines(seg)
	---@type WARItem[]
	local arr = {}
	for i = 2, #lines do
		arr[#arr + 1] = parse_line(lines[i])
	end
	return arr
end

local function parse_items()
	---@type WARItem[][]
	local obj = {}
	for i, seg in ipairs(stringx.split(config, "\n\n")) do
		obj[i] = parse_segment(seg)
	end
	return obj
end

local WAR = parse_items()

---@class Role
---@field hp     number
---@field damage number
---@field armor  number

---@param player Role
---@param boss   Role
local function can_win(player, boss)
	while player.hp > 0 and boss.hp > 0 do
		boss.hp = boss.hp - math.max(player.damage - boss.armor, 1)
		if boss.hp <= 0 then
			return true
		end
		player.hp = player.hp - math.max(boss.damage - player.armor, 1)
	end
	return player.hp > 0
end

---@class Build
---@field build Role
---@field cost  number

---@param builds      Build[]
---@param base_damage number
---@param base_armor  number
---@param base_cost   number
---@param rings       WARItem[]
local function backtracking_rings(builds, base_damage, base_armor, base_cost, rings)
	---@param stack    number[]
	---@param curr_idx number
	local function dfs(stack, curr_idx)
		if #stack <= 2 then
			local extra_damage, extra_armor, extra_cost = 0, 0, 0
			for i = 1, #stack do
				local ring = rings[stack[i]]
				extra_damage = extra_damage + ring.damage
				extra_armor = extra_armor + ring.armor
				extra_cost = extra_cost + ring.cost
			end
			builds[#builds + 1] = {
				build = {
					damage = base_damage + extra_damage,
					armor = base_armor + extra_armor,
					hp = 100,
				},
				cost = base_cost + extra_cost,
			}
		end
		if #stack < 2 then
			for i = curr_idx + 1, #rings do
				table.insert(stack, i)
				dfs(stack, i)
				table.remove(stack)
			end
		end
	end

	dfs({}, 0)
end

local function get_builds()
	---@type Build[]
	local builds = {}
	local weapons, armors, rings = WAR[1], WAR[2], WAR[3]
	for i = 1, #weapons do
		for j = 0, #armors do
			local damage = weapons[i].damage
			local armor = j > 0 and armors[j].armor or 0
			local cost = weapons[i].cost + (j > 0 and armors[j].cost or 0)
			backtracking_rings(builds, damage, armor, cost, rings)
		end
	end
	return builds
end

---@param boss Role
local function win_with_least_gold(boss)
	local builds = get_builds()
	table.sort(builds, function(a, b)
		return a.cost < b.cost
	end)
	local min = math.huge
	for _, build in pairs(builds) do
		---@type Role
		local b = {
			hp = boss.hp,
			damage = boss.damage,
			armor = boss.armor,
		}
		if build.cost < min and can_win(build.build, b) then
			min = build.cost
		end
	end
	return min
end

local function lose_with_most_gold(boss)
	local builds = get_builds()
	table.sort(builds, function(a, b)
		return a.cost > b.cost
	end)
	local max = 0
	for _, build in pairs(builds) do
		---@type Role
		local b = {
			hp = boss.hp,
			damage = boss.damage,
			armor = boss.armor,
		}
		if build.cost > max and not can_win(build.build, b) then
			max = build.cost
		end
	end
	return max
end

---@class Mod201521
---@field WAR WARItem[][]
---@field can_win function
---@field eval fun(boss_data: string, part: number?): number
return {
	WAR = WAR,
	can_win = can_win,
	eval = function(boss_data, part)
		part = part or 1
		local lines = stringx.splitlines(boss_data)
		local boss_parser = function(idx)
			return tonumber(stringx.split(lines[idx], ": ")[2]) or 0
		end
		---@type Role
		local boss = {
			hp = boss_parser(1),
			damage = boss_parser(2),
			armor = boss_parser(3),
		}

		return part == 1 and win_with_least_gold(boss) or lose_with_most_gold(boss)
	end,
}
