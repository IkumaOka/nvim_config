-- s/S はsubstitute.nvim が使用しているため <leader>j / <leader>J に割り当て
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    { "<leader>J", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Flash Remote" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
