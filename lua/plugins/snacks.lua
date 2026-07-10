return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    quickfile = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss Notifications" },
    { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
    { "]]", function() require("snacks").words.jump(vim.v.count1) end, desc = "Next word reference" },
    { "[[", function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev word reference" },
  },
}
