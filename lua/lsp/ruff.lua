return {
    on_attach = function(client, bufnr)
        -- Ruffのホバー機能がPyrightと衝突する場合は無効化する
        if client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
        end
    end,
    -- その他、Ruff固有の初期化オプションがあればここに記述
    init_options = {
        settings = {
            -- 実行引数の例
            args = {},
        }
    }
}
