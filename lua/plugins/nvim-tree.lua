return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  keys = {
    { "<leader>e",  "<cmd>NvimTreeToggle<CR>",         desc = "Toggle file explorer" },
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Find file in explorer" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>",       desc = "Collapse file explorer" },
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>",        desc = "Refresh file explorer" },
  },
  cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeCollapse", "NvimTreeRefresh" },
  config = function()
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
              arrow_closed = "→",
              arrow_open = "↓",
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

  end,
}
