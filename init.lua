vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})


require("config.lazy")
require("plugins")
