return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",
				separator_style = "slant",
				buffer_close_icon = "x",
				-- nvim-tree を表示している時に上にバッファを表示しないようにする
				offsets = {
					{ filetype = "NvimTree" },
				},
			},
		})
		vim.keymap.set("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
		vim.keymap.set("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "Prev buffer" })
		-- Shift + Tab で左のバッファへ (Tab は sidekick.nvim の NES ジャンプが優先、無ければ次のバッファへ)
		vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "Prev buffer" })
	end,
}
