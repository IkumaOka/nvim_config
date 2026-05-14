return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = {
      border = 'rounded',
    },
    select = {
      backend = { 'telescope', 'builtin' },
      telescope = require('telescope.themes').get_dropdown(),
    },
  },
}
