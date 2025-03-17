---@type LazySpec
local P = {
  -- A neovim plugin which just copies text matched by search to the system clipboard
  'obergodmar/yanklines.nvim',
  keys = {
    {
      '<leader>sy',
      function()
        require('yanklines').yank_lines()
      end,
      desc = '[Y]ank matched text',
      mode = { 'n' },
      id = 'yanklines',
    },
    {
      '<leader>sy',
      function()
        require('yanklines').yank_lines({ v_mode = true })
      end,
      desc = '[Y]ank matched text',
      mode = { 'v' },
      id = 'yanklines_v_block',
    },
  },
}

return P
