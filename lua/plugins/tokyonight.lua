return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true }
      }
    })
    vim.cmd("colorscheme tokyonight")
    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
  end
}
