---@type UtilsArray
local utils_array = require("utils.array")
local deepcopy = require("pl.tablex").deepcopy

local spells = {
	-- stylua: ignore start
	{ name = "Magic Missile", cost = 53,  damage = 4             },
	{ name = "Drain",         cost = 73,  damage = 2,   heal = 2 },
	{ name = "Shield",        cost = 113, armor  = 7,   last = 6 },
	{ name = "Poison",        cost = 173, damage = 3,   last = 6 },
	{ name = "Recharge",      cost = 229, mana   = 101, last = 5 },
	-- stylua: ignore end
}

local function serialize(v)
	if utils_array.is_array(v) then
		local stringbuilder = { "[" }
		for _, k in ipairs(v) do
			table.insert(stringbuilder, serialize(k))
			table.insert(stringbuilder, ", ")
		end
		stringbuilder[#stringbuilder] = "]"
		return table.concat(stringbuilder)
	elseif type(v) == "table" then
		local keys = {}
		for k, _ in pairs(v) do
			table.insert(keys, k)
		end
		table.sort(keys)

		local stringbuilder = { "{" }
		for _, k in ipairs(keys) do
			table.insert(stringbuilder, k .. ": " .. serialize(v[k]))
			table.insert(stringbuilder, ", ")
		end
		stringbuilder[#stringbuilder] = "}"
		return table.concat(stringbuilder)
	elseif type(v) == "string" then
		return v
	else
		return tostring(v)
	end
end

---@class Buff
---@field key     "armor"|"hp"|"mana"
---@field value    number
---@field remain   number
---@class PlayerState
---@field hp       number
---@field mana     number
---@field armor    number
---@field mana_acc number
---@field buffs    Buff[]
---@class BossState
---@field hp       number
---@field damage   number
---@field buffs    Buff[]
---@class PlayerInitState
---@field hp       number
---@field mana     number
---@class BossInitState
---@field hp       number
---@field damage   number

---@class Mod201522
---@field least_mana fun(player_init_state: PlayerInitState, boss_init_state: BossInitState, part: number?): number
return {
	least_mana = function(player_init_state, boss_init_state, part)
		part = part or 1
		local PLAYER_TURN, BOSS_TURN = 1, 0
		local min_mana = math.huge

		local memo = {}

		---@param role PlayerState | BossState
		local function update_buffs(role)
			if #role.buffs > 0 then
				local buffs = {}
				for _, b in ipairs(role.buffs) do
					role[b.key] = role[b.key] + b.value
					b.remain = b.remain - 1
					if b.remain > 0 then
						table.insert(buffs, b)
					end
				end
				role.buffs = buffs
			end
		end

		---@param player_state PlayerState
		---@param boss_state   BossState
		---@param turn         0 | 1
		local function simulate(player_state, boss_state, turn)
			local key = serialize({
				player_state = player_state,
				boss_state = boss_state,
				turn = turn,
			})
			if memo[key] then
				return
			end
			memo[key] = true

			if player_state.hp <= 0 then
				return
			end

			update_buffs(boss_state)
			if boss_state.hp <= 0 then
				min_mana = math.min(min_mana, player_state.mana_acc)
				return
			end

			update_buffs(player_state)
			if turn == BOSS_TURN then
				---@type BossState
				local next_boss_state = deepcopy(boss_state)
				---@type PlayerState
				local next_player_state = deepcopy(player_state)
				next_player_state.hp = next_player_state.hp
					- math.max(next_boss_state.damage - next_player_state.armor, 1)
				next_player_state.armor = 0
				simulate(next_player_state, next_boss_state, PLAYER_TURN)
			else
				if part == 2 then
					player_state.hp = player_state.hp - 1
					if player_state.hp <= 0 then
						return
					end
				end

				for _, spell in ipairs(spells) do
					if spell.cost > player_state.mana then
						goto continue
					end
					if
						utils_array.some(boss_state.buffs, function(b)
							return b.key == "hp"
						end) and spell.name == "Poison"
					then
						goto continue
					end
					if
						utils_array.some(player_state.buffs, function(b)
							return b.key == "mana"
						end) and spell.name == "Recharge"
					then
						goto continue
					end
					if
						utils_array.some(player_state.buffs, function(b)
							return b.key == "armor"
						end) and spell.name == "Shield"
					then
						goto continue
					end

					---@type BossState
					local next_boss_state = deepcopy(boss_state)
					---@type PlayerState
					local next_player_state = deepcopy(player_state)

					local n = spell.name
					if n == "Magic Missile" then
						next_boss_state.hp = next_boss_state.hp - spell.damage
					elseif n == "Drain" then
						next_boss_state.hp = next_boss_state.hp - spell.damage
						next_player_state.hp = next_player_state.hp + spell.heal
					elseif n == "Shield" then
						next_player_state.buffs[#next_player_state.buffs + 1] = {
							key = "armor",
							value = spell.armor,
							remain = spell.last,
						}
					elseif n == "Poison" then
						next_boss_state.buffs[#next_boss_state.buffs + 1] = {
							key = "hp",
							value = -spell.damage,
							remain = spell.last,
						}
					elseif n == "Recharge" then
						next_player_state.buffs[#next_player_state.buffs + 1] = {
							key = "mana",
							value = spell.mana,
							remain = spell.last,
						}
					end

					next_player_state.armor = 0
					next_player_state.mana = next_player_state.mana - spell.cost
					next_player_state.mana_acc = next_player_state.mana_acc + spell.cost
					simulate(next_player_state, next_boss_state, BOSS_TURN)

					::continue::
				end
			end
		end

		simulate({
			hp = player_init_state.hp,
			mana = player_init_state.mana,
			armor = 0,
			mana_acc = 0,
			buffs = {},
		}, {
			hp = boss_init_state.hp,
			damage = boss_init_state.damage,
			buffs = {},
		}, PLAYER_TURN)

		return min_mana
	end,
}
