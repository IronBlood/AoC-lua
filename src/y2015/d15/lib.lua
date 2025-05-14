local stringx = require("pl.stringx")
local split = stringx.split

---@class Recipe
---@field capacity   number
---@field durability number
---@field flavor     number
---@field texture    number
---@field calories   number

---@param lines string[]
local function parse_recipe(lines)
	---@type Recipe[]
	local recipes = {}
	for i = 1, #lines do
		local arr = split(lines[i], ", ")
		-- stylua: ignore start
		---@type Recipe
		local recipe = {
			capacity   = tonumber(split(arr[1], " ")[3]) or 0,
			durability = tonumber(split(arr[2], " ")[2]) or 0,
			flavor     = tonumber(split(arr[3], " ")[2]) or 0,
			texture    = tonumber(split(arr[4], " ")[2]) or 0,
			calories   = tonumber(split(arr[5], " ")[2]) or 0,
		}
		-- stylua: ignore end
		table.insert(recipes, recipe)
	end
	return recipes
end

---@param recipes   Recipe[]
---@param teaspoons number[]
local function calculate_scores(recipes, teaspoons)
	-- stylua: ignore start
	local arr = {
		capacity   = 0,
		durability = 0,
		flavor     = 0,
		texture    = 0,
	}
	-- stylua: ignore end
	for i = 1, #teaspoons do
		for k, v in pairs(recipes[i]) do
			if k ~= "calories" then
				arr[k] = arr[k] + v * teaspoons[i]
			end
		end
	end

	local m = 1
	for _, v in pairs(arr) do
		m = m * v
		if m <= 0 then
			return 0
		end
	end
	return m
end

---@param recipes   Recipe[]
---@param teaspoons number[]
local function calculate_calorie(recipes, teaspoons)
	local c = 0
	for i = 1, #teaspoons do
		c = c + recipes[i].calories * teaspoons[i]
	end
	return c
end

---Dynamic backpack-style allocation with on-the-fly calculations.
---@param teaspoons      number[] Current allocation of teaspoons.
---@param remaining      number   Remaining teaspoons to allocate.
---@param currIngredient number   Current ingredient index.
---@param numIngredients number   Total number of ingredients.
---@param calculateScore function Callback to calculate and compare scores.
local function backtracking(teaspoons, remaining, currIngredient, numIngredients, calculateScore)
	if currIngredient == numIngredients then
		teaspoons[currIngredient] = remaining
		calculateScore()
		return
	end

	for i = 1, (remaining - (numIngredients - currIngredient - 1)) do
		--TODO: check
		teaspoons[currIngredient] = i
		backtracking(teaspoons, remaining - i, currIngredient + 1, numIngredients, calculateScore)
	end
end

---@class Mod201515
---@field make_a_cookie fun(lines: string[]): number
---@field make_a_cookie_with_fixed_calorie fun(lines: string[], total_calorie: number): number
return {
	make_a_cookie = function(lines)
		local recipes = parse_recipe(lines)

		local teaspoons = {}
		for i = 1, #recipes do
			teaspoons[i] = 0
		end

		local max = 0
		backtracking(teaspoons, 100, 1, #recipes, function()
			max = math.max(max, calculate_scores(recipes, teaspoons))
		end)
		return max
	end,
	make_a_cookie_with_fixed_calorie = function(lines, total_calorie)
		local recipes = parse_recipe(lines)

		local teaspoons = {}
		for i = 1, #recipes do
			teaspoons[i] = 0
		end

		local max = 0
		backtracking(teaspoons, 100, 1, #recipes, function()
			if calculate_calorie(recipes, teaspoons) == total_calorie then
				max = math.max(max, calculate_scores(recipes, teaspoons))
			end
		end)
		return max
	end,
}
