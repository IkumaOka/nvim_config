return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup()

        -- パーサーのインストール（非同期）
        local parsers = {
            "python", "lua", "vim", "vimdoc", "bash",
            "json", "yaml", "toml", "markdown", "markdown_inline",
            "javascript", "typescript", "rust",
        }
        for _, lang in ipairs(parsers) do
            pcall(require("nvim-treesitter").install, lang)
        end

    end,
}
