local comb = require("cartesian_product")

local sections = {
	{ "A_type1", "A_type2" },
	{ "B_opt1", "B_opt2", "B_opt3" },
	{ "C_target1" },
}

-- 全パターンの組み合わせを計算
local all_patterns = comb.cartesian_product(sections)

-- 結果を確認してみる
for i, pattern in ipairs(all_patterns) do
	print("\n")
	print(string.format("%d:", i))
	print(string.format("[%s]", table.concat(pattern, "\n")))
end
