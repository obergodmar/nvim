---@type LazyPluginSpec
local P = {
  'obergodmar/nvim-tree.lua',
  opts = {
    view = {
      centralize_selection = true,
      width = 50,
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
    renderer = {
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
    diagnostics = {
      enable = true,
      show_on_dirs = true,
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
        quit_on_open = true,
      },
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
