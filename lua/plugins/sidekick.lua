return {
    "folke/sidekick.nvim",
    opts = {
        cli = {
            mux = {
                backend = "zellij",
                enabled = true,
                floating = false,
            },
        },
    },
    keys = {
        -- 次の編集提案 (Edit Suggestion) へ移動、または適用
        {
            "<tab>",
            function()
                if not require("sidekick").nes_jump_or_apply() then
                    return "<Tab>"
                end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        -- メインのトグル操作 (CLI)
        {
            "<c-.>",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle",
            mode = { "n", "t", "i", "x" },
        },
        {
            "<leader>aa",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle CLI",
        },
        -- CLI セッションの選択
        {
            "<leader>as",
            function() require("sidekick.cli").select() end,
            desc = "Select CLI",
        },
        -- セッションのデタッチ（切り離し）
        {
            "<leader>ad",
            function() require("sidekick.cli").close() end,
            desc = "Detach a CLI Session",
        },
        -- コンテキスト送信系
        {
            "<leader>at",
            function() require("sidekick.cli").send({ msg = "{this}" }) end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<leader>af",
            function() require("sidekick.cli").send({ msg = "{file}" }) end,
            desc = "Send File",
        },
        {
            "<leader>av",
            function() require("sidekick.cli").send({ msg = "{selection}" }) end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
        {
            "<leader>ap",
            function() require("sidekick.cli").prompt() end,
            mode = { "n", "x" },
            desc = "Sidekick Select Prompt",
        },
        -- Cursor を直接起動
        {
            "<leader>ac",
            function() require("sidekick.cli").toggle({ name = "cursor", focus = true }) end,
            desc = "Sidekick Toggle Cursor",
        },
    },
}
