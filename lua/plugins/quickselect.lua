---@type LazySpec
local P = {
  'obergodmar/quickselect.nvim',
  event = 'VeryLazy',
  opts = {
    patterns = {
      '[~|/][^%s]+',
      -- Relative path starting with ./ or ../
      '%.%.?/[^%s]+',
      -- Single-quoted strings
      "'[^']*'",
      -- Double-quoted strings
      '"[^"]*"',
      -- Backtick-quoted strings
      '`[^`]*`',
      -- Branch names with multiple segments
      '[%w._%-]+%/[%w._%-]+',
    },
  },

  keys = {
    {
      mode = { 'n' },
      '<leader>qs',
      function()
        require('quickselect').quick_select()
      end,
      desc = 'Quick select',
    },
    {
      mode = { 'n' },
      '<leader>qy',
      function()
        require('quickselect').quick_yank()
      end,
      desc = 'Quick yank',
    },
  },
}

return P
