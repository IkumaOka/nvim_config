return {
	"neovim/nvim-lspconfig",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim",           version = "^1.0.0" },
		{ "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
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

		local function enable_format_on_save(client, bufnr, name)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr, name = name })
					end,
				})
			end
		end

		-- Python (lint と型チェック用)
		lspconfig.pyright.setup {
			capabilities = capabilities,
		}

		-- Ruff (保存時に自動フォーマット)
		lspconfig.ruff.setup {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				enable_format_on_save(client, bufnr, "ruff")
			end,
		}

		-- Lua (保存時に lua_ls でフォーマット)
		lspconfig.lua_ls.setup {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				enable_format_on_save(client, bufnr, "lua_ls")
			end,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		}

		vim.lsp.enable(ensure_installed)
	end
}
