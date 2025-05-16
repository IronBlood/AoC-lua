---@type Mod201518
local lib = require("y2015.d18.lib")

describe("2015-12-18 p1", function()
	local testcases = {
		{ [[.#.#.#
...##.
#....#
..#...
#.#..#
####..]], 4, 4 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.count_lights(tc[1], tc[2]))
		end)
	end
end)

describe("2015-12-18 p2", function()
	local testcases = {
		{ [[##.#.#
...##.
#....#
..#...
#.#..#
####.#]], 5, 17 },
		{ [[#.##.#
####.#
...##.
......
#...#.
#.####]], 4, 17 },
		{ [[#..#.#
#....#
.#.##.
...##.
.#..##
##.###]], 3, 17 },
		{ [[#...##
####.#
..##.#
......
##....
####.#]], 2, 17 },
		{ [[#.####
#....#
...#..
.##...
#.....
#.#..#]], 1, 17 },
		{ [[##.###
.##..#
.##...
.##...
#.#...
##...#]], 0, 17 },
	}
	for i, tc in ipairs(testcases) do
		it("test-" .. i, function()
			assert.are_same(tc[3], lib.count_lights(tc[1], tc[2], 2))
		end)
	end
end)
