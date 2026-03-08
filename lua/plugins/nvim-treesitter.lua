return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    -- main を指定すると、ここ（nvim-treesitter.configs）が読み込まれた後に opts が適用されます
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = { "python", "lua", "vim", "vimdoc", "bash" },
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    },
}
