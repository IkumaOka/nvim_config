return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "python", "lua", "vim", "vimdoc", "bash",
                "json", "yaml", "toml", "markdown", "markdown_inline",
                "javascript", "typescript", "rust",
            },
        })
    end,
}
