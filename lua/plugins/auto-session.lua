return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      log_level = "error",
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/Dev/", "~/Documents" },
      auto_restore = false,
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
  end,
}
