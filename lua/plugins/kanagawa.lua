return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
        require("kanagawa").setup({
            transparent = true,
        })
        vim.cmd("colorscheme kanagawa-wave")
        -- nvim-tree はcolorschemeが管理しないため個別に透明化
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
    end,
}
