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
      actions = {
        open_file = {
          window_picker = {
            enable = false
          }
        }
      },
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "→", -- arrow when folder is arrow_closed
              arrow_open = "↓", -- arrow when folder is open
            }
          }
        }
      },
      filters = {
        dotfiles = false,
        custom = { ".DS_Store" }
      },
      git = {
        ignore = false
      }
    })

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find file in explorer" })
    vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end,
}
