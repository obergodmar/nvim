---@type LazySpec
local P = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    disable_netrw = true,
    view = {
      -- preserve_window_proportions = true,
      centralize_selection = true,
      width = {
        min = 30,
        max = -1,
      },
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
    renderer = {
      full_name = true,
      add_trailing = true,
      group_empty = true,
      highlight_git = 'all',
      highlight_diagnostics = 'all',
      highlight_opened_files = 'all',
      highlight_modified = 'all',
      icons = {
        web_devicons = {
          folder = {
            enable = true,
          },
        },
        glyphs = {
          git = {
            unstaged = '-',
            staged = '+',
            unmerged = '',
            renamed = '➜',
            untracked = '?',
            deleted = '',
            ignored = '!!',
          },
        },
      },
    },
    update_focused_file = {
      enable = false,
    },
    diagnostics = {
      enable = false,
    },
    modified = {
      enable = true,
    },
    actions = {
      expand_all = {
        max_folder_discovery = 300,
        exclude = { 'node_modules', '.git' },
      },
      open_file = {
        quit_on_open = false,
      },
    },
    git = {
      -- for performance reasons
      enable = false,
    },
    trash = {
      cmd = 'trash-put',
    },
    filesystem_watchers = {
      enable = false,
      ignore_dirs = {
        'node_modules',
      },
    },
  },
  keys = {
    {
      '<leader>F',
      '<cmd>NvimTreeFindFile<CR>',
      id = 'nvim_tree_open',
      desc = 'nvim tree reveal [F]ile',
    },
    {
      '<leader><tab>',
      '<cmd>NvimTreeToggle<CR>',
      id = 'nvim_tree_toggle',
      desc = 'nvim tree [T]oggle',
    },
  },
}

return P
