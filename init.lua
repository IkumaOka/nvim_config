vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("core.keymaps")

vim.opt.rtp:prepend("/Users/ikuma.oka/.opam/default/share/ocp-indent/vim")
vim.env.PATH = "/Users/ikuma.oka/.opam/default/bin:" .. vim.env.PATH

local opt = vim.opt
opt.number = true
vim.schedule(function() opt.clipboard = "unnamedplus" end)
opt.cursorline = true
opt.mouse = 'a'
opt.fileencoding = 'utf-8'
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.splitright = true
opt.splitbelow = true
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- pyファイルの起動が遅い時に使う。which python の結果を貼る。
-- vim.g.python3_host_prog = "/Users/ikuma.oka/.pyenv/arm64/shims/python"


if vim.fn.has("persistent_undo") == 1 then
  local undodir = vim.fn.stdpath("data") .. "/undo"
  vim.fn.mkdir(undodir, "p")
  opt.undodir = undodir
  opt.undofile = true
end

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
      { focus = false, focusable = true, border = "rounded" }
    )
  end)
end

-- ダイアログが開いてるかを確認する関数
local function has_any_floating_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- 手動コマンド
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gb", "<C-o>", opts)                -- gdで定義ジャンプした後、gbで戻る
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Quickfix List は :ccl で閉じる
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
    vim.keymap.set("n", "K", function() hover_no_focus(bufnr) end, opts)
    vim.keymap.set('n', 'oe', function()
      local _, winid = vim.diagnostic.open_float(nil, {
        focus = true,
        border = "rounded",
        close_events = { "InsertEnter", "FocusLost"
        },
      })
      if winid and vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_set_current_win(winid)
      end
    end, opts)
    vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)

    -- 自動ポップアップ (Diagnostics)
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        if has_any_floating_window() then
          return
        end
        vim.diagnostic.open_float(nil, {
          focusable = false,
          focus = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "if_many",
          prefix = "",
          scope = "cursor",
        })
      end
    })
  end,
})

-- ホバーや診断表示の遅延時間短縮
opt.updatetime = 300
-- ディレクトリ・ファイル引数で起動したときにツリーを自動で開く
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    if vim.fn.isdirectory(data.file) == 1 then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.open()
    elseif vim.fn.filereadable(data.file) == 1 then
      require("nvim-tree.api").tree.open()
      vim.cmd("wincmd p")
    end
  end,
})

require("config.lazy")
require("plugins")

