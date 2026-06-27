return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "BufReadPost",
  config = function()
    require("trouble").setup()

    local keymap = vim.keymap
    keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
    keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics (Trouble)" })
    keymap.set("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "LSP references (Trouble)" })
    keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
  end,
}
