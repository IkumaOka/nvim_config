return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = { 
    { "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" }, 
  },
  config = function()
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
	cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done()
    )
    local luasnip = require("luasnip")
    require("luasnip/loaders/from_vscode").lazy_load()
    cmp.setup({
	  snippet = {
	  expand = function(args)
		luasnip.lsp_expand(args.body)
	  end,
	  },
	  mapping = cmp.mapping.preset.insert({
	  ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- 補完候補のドキュメントを上にスクロール
	  ["<C-f>"] = cmp.mapping.scroll_docs(4), -- 補完候補のドキュメントを下にスクロール
	  ["<C-Space>"] = cmp.mapping.complete(), -- 手動で補完候補を表示
	  ["<C-e>"] = cmp.mapping.abort(), -- 補完を中断して閉じる
	  ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 補完確定 (現在選択中の候補を使用)
	  }),
	  sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	    { name = "luasnip", priority_weight = 20 }, -- LuaSnip を補完候補に含める
	    }, {
	    { name = "buffer" }, -- バッファの内容を補完候補に含める
	  }),
	})
  end
}
