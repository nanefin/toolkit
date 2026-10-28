local M = {}

--- 複数のセクション（可変長配列の配列）から全パターンの組み合わせ（直積）を生成する
-- @param sections table セクションの配列。例: { {a1, a2}, {b1, b2, b3}, {c1} }
-- @return table すべての組み合わせパターンのリスト
function M.cartesian_product(sections)
	-- 初期状態として「空の組み合わせ」を1つだけ持った状態からスタート
	local result = { {} }

	for _, section_values in ipairs(sections) do
		local next_result = {}
		for _, prefix in ipairs(result) do
			for _, val in ipairs(section_values) do
				-- これまでの組み合わせをコピーして、新しいセクションの値を1つ追加する
				local new_combination = {}
				for _, v in ipairs(prefix) do
					table.insert(new_combination, v)
				end
				table.insert(new_combination, val)
				table.insert(next_result, new_combination)
			end
		end
		result = next_result
	end

	return result
end

return M
