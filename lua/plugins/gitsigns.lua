return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, l, r, opts)
        opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
        vim.keymap.set(mode, l, r, opts)
      end
      map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
      map("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })
      map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
      map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
      map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
    end,
  },
}
