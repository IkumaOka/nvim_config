return {
  "neovim/nvim-lspconfig",
  opts = {},
  dependencies = {
   { "mason-org/mason.nvim", version = "^1.0.0" },
   { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()

    require("mason").setup()
    local ensure_installed = {'lua_ls', 'pyright', 'ruff', 'rust_analyzer', 'ts_ls', 'jsonls'}
    require("mason-lspconfig").setup {
	    automatic_installation = true,
	    ensure_installed = ensure_installed,
    }
    vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
          diagnostics = {
            globals = { 'vim' }
          },
        }
      },
    })
    vim.lsp.enable(ensure_installed)
  end
}
