return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    local ss = require("smart-splits")
    -- setup merges via vim.tbl_deep_extend, which merges list-configs by
    -- index rather than replacing them, so passing {} here would NOT clear
    -- the plugin's defaults (ignored_buftypes = {nofile,quickfix,prompt},
    -- ignored_filetypes = {NvimTree}); overwrite each index explicitly so
    -- nvim-tree (buftype=nofile, filetype=NvimTree) stops being skipped.
    ss.setup({
      ignored_buftypes = { "", "quickfix", "prompt" },
      ignored_filetypes = { "" },
    })

    vim.keymap.set("n", "<C-h>", ss.move_cursor_left)
    vim.keymap.set("n", "<C-j>", ss.move_cursor_down)
    vim.keymap.set("n", "<C-k>", ss.move_cursor_up)
    vim.keymap.set("n", "<C-l>", ss.move_cursor_right)

    vim.keymap.set("n", "<A-h>", ss.resize_left)
    vim.keymap.set("n", "<A-j>", ss.resize_down)
    vim.keymap.set("n", "<A-k>", ss.resize_up)
    vim.keymap.set("n", "<A-l>", ss.resize_right)
  end,
}
