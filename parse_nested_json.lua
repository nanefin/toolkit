-- script.lua
-- 実行コマンド例: nvim -l script.lua

local raw_data = [[
]]

-- 1. 最初に見つかる '{' と、一番最後に見つかる '}' の位置を特定する
local start_idx = raw_data:find("{")
local rev_end_idx = raw_data:reverse():find("}")

if not start_idx or not rev_end_idx then
        print("Error: Options object not found")
        return
end

-- reverse() したインデックスを元の文字列のインデックスに変換
local end_idx = #raw_data - rev_end_idx + 1
local json_candidate = raw_data:sub(start_idx, end_idx)

-- 2. Neovim標準のビルトインJSONパーサーで外側をデコード
local ok, options = pcall(vim.json.decode, json_candidate)
if not ok then
        print("Failed to decode outer JSON: " .. tostring(options))
        return
end

-- 3. ネストされた文字列化JSONを再帰的に解除・展開する関数
local function parse_nested_json(val)
        if type(val) == "string" then
                local success, decoded = pcall(vim.json.decode, val)
                if success then
                        return parse_nested_json(decoded)
                else
                        return val
                end
        elseif type(val) == "table" then
                local result = {}
                for k, v in pairs(val) do
                        result[k] = parse_nested_json(v)
                end
                return result
        end
        return val
end

-- 4. 適用
local final_payload = parse_nested_json(options)

-- 5. Neovim の vim.inspect で構造を美しく出力
print(vim.inspect(final_payload))