---@type LazySpec
local P = {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = false,
        suggestions = 20,
      },
    },
  },
  config = function(_, opts)
    require('which-key.plugins.presets').operators['v'] = nil
    require('which-key').setup(opts)
  end,
}

return P
