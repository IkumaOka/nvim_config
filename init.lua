vim.o.number = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.opt.mouse = 'a'
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.termguicolors = true

-- pyファイルの起動が遅い時に使う。which python の結果を貼る。
-- vim.g.python3_host_prog = "/Users/ikuma.oka/.pyenv/arm64/shims/python"

-- nvim-tree や bufferline などの背景も透明にする
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })       -- フォーカスしていないウィンドウ
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" }) -- nvim-tree本体
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })    -- 波線(~)の部分

if vim.fn.has("persistent_undo") == 1 then
    vim.o.undodir = vim.fn.expand("~/.vim/undo")
    vim.o.undofile = true
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
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- Quickfix List は :ccl で閉じる
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
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
vim.o.updatetime = 300
require("config.lazy")
require("plugins")

-- Ctrl + h で左側（ツリー）にフォーカス
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })

-- Ctrl + l で右側（エディタ）にフォーカス
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
