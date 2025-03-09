---@type LazyPluginSpec
local P = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme('catppuccin-macchiato')
  end,
}

return P
