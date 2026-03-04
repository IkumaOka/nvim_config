return {
    "neovim/nvim-lspconfig",
    opts = {},
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("mason").setup()

        local ensure_installed = { 'lua_ls', 'pyright', 'ruff', 'rust_analyzer', 'ts_ls', 'jsonls' }
        require("mason-lspconfig").setup {
            automatic_installation = true,
            ensure_installed = ensure_installed,
        }

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        -- auto formatting when file saved
        local on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                    end,
                })
            end
        end

        for _, server_name in ipairs(ensure_installed) do
            local opts = {
                capabilities = capabilities,
                on_attach = on_attach,
            }
            local has_custom_opts, custom_opts = pcall(require, "lsp." .. server_name)
            if has_custom_opts then
                opts = vim.tbl_deep_extend("force", opts, custom_opts)
            end

            vim.lsp.config(server_name, opts)
        end
        vim.lsp.enable(ensure_installed)
    end
}
