---@type LazySpec
local P = {
  -- Nvim Treesitter configurations and abstraction layer
  'nvim-treesitter/nvim-treesitter',
  tag = 'v0.10.0',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        multiwindow = true,
        multiline_threshold = 1,
        mode = 'topline',
      },
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-refactor',
  },
  config = function()
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))

    require('nvim-treesitter.configs').setup({
      additional_vim_regex_highlighting = false,
      modules = {},
      ignore_install = {},
      sync_install = true,
      ensure_installed = {
        'markdown',
        'markdown_inline',
        'regex',
        'lua',
        'vim',
        'bash',
        'comment',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        lsp_interop = {
          enable = false,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = { query = '@class.outer', desc = 'Next class start' },

            [']o'] = '@loop.*',

            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          goto_next = {
            [']e'] = '@conditional.outer',
          },
          goto_previous = {
            ['[e'] = '@conditional.outer',
          },
        },
      },
      refactor = {
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = false,
        },
        highlight_current_scope = { enable = false },
      },
    })
  end,
}

return P
