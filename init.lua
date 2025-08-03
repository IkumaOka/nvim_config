vim.o.number = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true


if vim.fn.has("persistent_undo") == 1 then
  vim.o.undodir = vim.fn.expand("~/.vim/undo")
  vim.o.undofile = true
end


vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- 手動コマンド
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'oe', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)

    -- 自動ポップアップ (Diagnostics)
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
      local curr_pos = vim.api.nvim_win_get_cursor(0)
      if vim.b._last_diagnostic_float_pos and
          vim.deep_equal(vim.b._last_diagnostic_float_pos, curr_pos) then
        return
      end
    vim.b._last_diagnostic_float_pos = curr_pos
        vim.diagnostic.open_float(nil, {
          focusable = false, -- ESCで消さなくていい
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "if_many", -- エラーソース表示
          prefix = "", -- プレフィックスなし
          scope = "cursor",
        })
      end
    })

    -- 自動ポップアップ (Hover, optional)
    vim.api.nvim_create_autocmd("CursorHoldI", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.hover()
      end
    })
  end,
})

-- ホバーや診断表示の遅延時間短縮
vim.o.updatetime = 300 -- デフォルト4000ms → 300msに
require("config.lazy")
require("plugins")
