local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function win_num()
  return vim.fn.winnr()
end

local function git_head()
  local buf_name = vim.fn.bufname()

  if buf_name and string.match(buf_name, 'fugitive') then
    return vim.fn.FugitiveStatusline()
  end

  return ''
end

local function session()
  return require('auto-session.lib').current_session_name(true)
end

local function mapBufferlineKeys(goToIndex)
  return {
    '<leader>' .. goToIndex,
    '<cmd>lua require("bufferline").go_to(' .. goToIndex .. ', true)<cr>',
    id = 'bufferline_go_to_' .. goToIndex,
    desc = 'Go to ' .. goToIndex .. ' tab',
    mode = 'n',
  }
end

local function generateBufferlineKeys()
  local keys = {}
  for i = 1, 9, 1 do
    table.insert(keys, mapBufferlineKeys(i))
  end
  return keys
end

return {
  {
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        theme = 'catppuccin',
      },
      sections = {
        lualine_a = { win_num, 'filesize', 'mode' },
        lualine_b = {
          'branch',
          {
            'diff',
            source = diff_source,
            diff_color = {
              added = 'GitSignsAdd',
              modified = 'GitSignsChange',
              removed = 'GitSignsDelete',
            },
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'coc' },
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
              error = 'DiagnosticError',
              warn = 'DiagnosticWarn',
              info = 'DiagnosticInfo',
              hint = 'DiagnosticHint',
            },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
          },
        },
        lualine_c = {},
        lualine_x = {
          'g:coc_status',
          "require'lsp-status'.status()",
          session,
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'selectioncount', 'searchcount', 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = { win_num, 'filesize' },
        lualine_b = { git_head },
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'lazy', 'nvim-tree', 'fzf', 'mason', 'toggleterm' },
    },
  },
  {
    -- Tabs replacer
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'BufEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local macchiato = require('catppuccin.palettes').get_palette('macchiato')

      require('bufferline').setup({
        ---@type bufferline.Options
        ---@diagnostic disable-next-line: missing-fields
        options = {
          mode = 'tabs',
          numbers = 'ordinal',
          indicator = { style = 'underline' },
          -- diagnostics = require('helpers.utils').is_coc_instead_of_lspconfig() and 'coc' or 'nvim_lsp',
          diagnostics = nil,
          color_icons = true,
          always_show_bufferline = false,
          show_buffer_close_icons = false,
          show_duplicate_prefix = false,
          show_close_icon = false,
          separator_style = 'thin',
          modified_icon = '[+]',
          offsets = {
            {
              filetype = 'NvimTree',
              text_align = 'center',
              separator = true,
            },
          },
        },

        highlights = require('catppuccin.special.bufferline').get_theme({
          custom = {
            all = {
              fill = { bg = macchiato.mantle },
            },
          },
        }),
      })
    end,
    keys = generateBufferlineKeys(),
  },
  {
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
  },
  {
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
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = { char = '▏' },
    },
  },
}
