return {
  -- nvim-lspconfig と関連プラグインをここでまとめて定義します
  "neovim/nvim-lspconfig",
  dependencies = {
    {"williamboman/mason.nvim", config = true},         -- LSPサーバー管理
    {"williamboman/mason-lspconfig.nvim", config = true}, -- Masonとlspconfigの連携
    "hrsh7th/cmp-nvim-lsp",            -- nvim-cmpとLSPの連携
    -- "hrsh7th/vim-vsnip",             -- スニペットエンジンが必要ならここに追加
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Masonのセットアップ
    require("mason").setup()

    -- mason-lspconfig のセットアップハンドラ
    -- これにより、MasonでインストールされたLSPサーバーが自動的に設定されます
    mason_lspconfig.setup({
      automatic_enable = {
	"lua_ls",
	"vimls",
	"pyright",
	"rust_analyzer"
      },
      handlers = {
      -- デフォルトのハンドラ: MasonでインストールされたすべてのLSPサーバーに適用されます
      function(server_name)
   	lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- LSPサーバーが起動した際に実行される共通の処理（キーバインドなど）
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            -- ファイル保存時にフォーマットする（フォーマッターが設定されている場合）
            vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)'
          end,
        })
      end,

      -- 個別のLSPサーバーにカスタム設定を適用する場合
      -- Python (pyright) のカスタム設定例
      ["pyright"] = function()
        lspconfig.pyright.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- on_attach も共通のものを呼び出すか、個別に記述できます
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)'
          end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- platform = "Linux", -- お使いのOSに合わせて
              },
            },
          },
        })
      end,

      -- TypeScript/JavaScript (tsserver) のカスタム設定例
      ["tsserver"] = function()
        lspconfig.tsserver.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)'
          end,
          -- init_options など、tsserver特有の設定があればここに追加
          -- 例えば、VueやReactの言語サポートプラグインを有効にする場合など
          -- init_options = {
          --   plugins = {
          --     {
          --       name = "@vue/typescript-plugin",
          --       location = "/path/to/node_modules/@vue/typescript-plugin", -- 適切なパスを指定
          --       languages = { "vue" },
          --     },
          --   },
          -- },
        })
      end,

      -- Rust (rust_analyzer) のカスタム設定例
      ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)'
          end,
          -- rust_analyzer特有の設定（例: インレイヒントの有効化）
          settings = {
            ['rust-analyzer'] = {
              inlayHints = {
                enable = true,
                bindingModeHints = { enable = true },
                chainingHints = { enable = true },
                closureReturnTypeHints = { enable = true },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
            },
          },
        })
      end,
      },
    })

    --- LSPの共通キーバインド（LSPプラグインがロードされた後に設定されるようにconfig内に記述） ---
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

    --- LSPハンドラと参照ハイライト ---
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false } -- 仮想テキストでの診断表示を無効にする例
    )

    vim.cmd [[
      set updatetime=500
      highlight LspReferenceText cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceRead cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end,
}
