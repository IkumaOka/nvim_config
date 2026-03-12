return {
    settings = {
        ['rust-analyzer'] = {
            -- 保存時に cargo check を実行する (デフォルトで有効ですが明示)
            checkOnSave = {
                command = "clippy", -- cargo check の代わりに clippy を使うとより厳密です
            },
            -- 型ヒント（Inlay Hints）の設定
            inlayHints = {
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                parameterHints = { enable = true },
                typeHints = { enable = true },
            },
            -- 補完設定
            completion = {
                callable = { snippets = "fill_arguments" },
            },
            -- プロジェクト読み込み設定
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
            },
            procMacro = {
                enable = true,
            },
        },
    },
}
