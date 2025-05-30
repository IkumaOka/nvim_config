return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspconfig.pyright.setup{
		  lspconfig.pyright.setup {
            capabilities = capabilities
          }
		}
    end,
}
