return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- netrw を無効化（nvim-tree の動作を邪魔しないようにする）
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- 24bit カラーを有効化
    vim.opt.termguicolors = true

    -- nvim-tree の設定
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })

    -- <leader>e で NvimTree を開閉できるように設定
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end,
}

