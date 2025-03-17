---@type LazySpec
local P = {
  -- A search panel for neovim.
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>S',
      function()
        require('spectre').open()
      end,
      id = 'spectre_open',
      desc = 'Open',
      mode = 'n',
    },
    {
      '<leader>sw',
      function()
        require('spectre').open_visual({ select_word = true })
      end,
      id = 'spectre_search_current',
      desc = '[S]earch current [W]ord',
      mode = 'n',
    },
    {
      '<leader>sw',
      function()
        require('spectre').open_visual()
      end,
      id = 'spectre_search_current_visual',
      desc = '[S]earch current [W]ord',
      mode = 'v',
    },
    {
      '<leader>sp',
      function()
        require('spectre').open_file_search({ select_word = true })
      end,
      id = 'spectre_search_in_current_file',
      desc = '[S]earch in current file',
      mode = 'n',
    },
  },
}

return P
