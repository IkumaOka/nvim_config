vim.o.number = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.opt.mouse = 'a'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

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

-- hover 時にフォーカスされないようにする関数
local function hover_no_focus(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients == 0 then return end
  local client = clients[1]

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  vim.lsp.buf_request(bufnr, "textDocument/hover", params, function(err, result, ctx, _)
    if err or not (result and result.contents) then return end

    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

    if vim.tbl_isempty(markdown_lines) then return end

    -- フォーカスを奪わない hover
    vim.lsp.util.open_floating_preview(
      markdown_lines,
      "markdown",
      { focus = false, focusable = false, border = "rounded" }
    )
  end)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- 手動コマンド
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", function() hover_no_focus(bufnr) end, opts)
    vim.keymap.set('n', 'oe', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)

    -- 自動ポップアップ (Diagnostics)
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.open_float(nil, {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "if_many",
          prefix = "",
          scope = "cursor",
        })
      end
    })

    -- 自動ポップアップ (Hover, optional)
    vim.api.nvim_create_autocmd("CursorHoldI", {
      buffer = bufnr,
      callback = function()
        hover_no_focus(bufnr)
      end
    })
  end,
})

-- ホバーや診断表示の遅延時間短縮
vim.o.updatetime = 300 -- デフォルト4000ms → 300msに
require("config.lazy")
require("plugins")
