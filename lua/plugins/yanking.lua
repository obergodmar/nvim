return {
  {
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
  },
  {
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
  },
}
