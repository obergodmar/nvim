vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local vim_data_path = vim.fn.stdpath('data')
local lazypath = vim_data_path .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },
}, {
  root = vim_data_path .. '/plugins',
  change_detection = { enabled = false },
  install = {
    missing = true,
  },
  ui = {
    size = { width = 1.0, height = 1.0 },
    backdrop = 0,
  },
})
