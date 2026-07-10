return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    },
    appearance = { nerd_font_variant = "mono" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      menu = {
        border = "rounded",
        draw = { treesitter = { "lsp" } },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
    },
    signature = { enabled = true },
  },
}
