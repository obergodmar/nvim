return {
  ---@type LazySpec
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          multiwindow = true,
          multiline_threshold = 1,
          mode = 'topline',
        },
      },
    },

    config = function()
      require('nvim-treesitter').setup({})
      require('nvim-treesitter').install({
        'gitcommit',
        'markdown',
        'markdown_inline',
        'regex',
        'lua',
        'vim',
        'bash',
        'comment',
      })

      local ts_move = require('nvim-treesitter-textobjects.move')
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        ts_move.goto_next('@function.outer', 'textobjects')
      end, { desc = 'Next function boundary' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        ts_move.goto_previous('@function.outer', 'textobjects')
      end, { desc = 'Previous function boundary' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
        ts_move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
        ts_move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']p', function()
        ts_move.goto_next_start('@parameter.inner', 'textobjects')
      end, { desc = 'Next parameter' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[p', function()
        ts_move.goto_previous_start('@parameter.inner', 'textobjects')
      end, { desc = 'Previous parameter' })

      -- Repeat moves with ;,
      local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
    end,
  },
}
