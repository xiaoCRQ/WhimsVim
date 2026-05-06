-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_check_order = false
vim.opt.clipboard = "unnamedplus"
vim.opt.iskeyword = "_,48-57,A-Z,a-z"
vim.wo.wrap = false
vim.o.timeoutlen = 170
vim.o.mouse = "a"
vim.o.swapfile = false -- 关闭 打开文件询问
