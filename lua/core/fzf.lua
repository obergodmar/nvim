local keys = require('helpers.search.keys')

local get_cwd = function()
  local cmd

  if require('helpers.utils').is_win() then
    cmd = 'git rev-parse --show-toplevel 2> nul || echo %CD%'
  else
    cmd = vim.fn.systemlist('git rev-parse --show-toplevel 2> /dev/null || echo "$PWD"')[1]
  end

  local cwd = vim.fn.systemlist(cmd)[1]
  return cwd
end

local get_fd_cmd = function()
  local cmd

  if require('helpers.utils').is_win() then
    cmd = 'fd --absolute-path . ' .. get_cwd() .. ' --color=never --type f --hidden --follow --exclude .git 2> nul'
  else
    cmd = 'fd --absolute-path . '
      .. get_cwd()
      .. ' --color=never --type f --hidden --follow --exclude .git 2> /dev/null'
  end

  return cmd
end

---@type LazySpec
local P = {
  'obergodmar/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  opts = {
    'fzf-native',
    winopts = {
      fullscreen = false,
      border = 'rounded',
      preview = {
        default = 'builtin',
        layout = 'vertical',
        vertical = 'down:75%',
        border = 'noborder',
      },
    },
    buffers = {
      ignore_current_buffer = true,
      show_unloaded = true,
    },
    files = {
      fzf_opts = {
        ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-files-history',
      },
    },
    grep = {
      fzf_opts = {
        ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-grep-history',
      },
    },
    keymap = {
      builtin = {
        false,
        ['<Esc>'] = 'hide',
        ['<M-F1>'] = 'toggle-help',
        ['<M-F2>'] = 'toggle-fullscreen',
        ['<M-F5>'] = 'toggle-preview-ccw',
        ['<M-F6>'] = 'toggle-preview-cw',
        ['<M-down>'] = 'preview-page-down',
        ['<M-up>'] = 'preview-page-up',
        ['<M-S-down>'] = 'preview-down',
        ['<M-S-up>'] = 'preview-up',
      },
    },
  },
  keys = {
    keys.oldfiles(function()
      -- vim.cmd('rshada!')
      require('fzf-lua').oldfiles({ cwd_only = true })
    end, 'fzf'),

    keys.buffers(function()
      require('fzf-lua').buffers()
    end, 'fzf'),

    keys.resume(function()
      require('fzf-lua').resume()
    end, 'fzf'),

    keys.find_files(function()
      require('fzf-lua').files({
        use_absolute_paths = true,
        cmd = get_fd_cmd(),
      })
    end, 'fzf'),

    keys.grep_string(function()
      require('fzf-lua').grep_cword()
    end, 'fzf'),

    keys.live_grep(function()
      require('fzf-lua').live_grep_native()
    end, 'fzf'),

    keys.live_grep_args(function()
      require('fzf-lua').live_grep_glob()
    end, 'fzf'),

    keys.git_files(function()
      require('fzf-lua').git_files({
        cmd = get_fd_cmd(),
      })
    end, 'fzf'),

    keys.git_commits(function()
      require('fzf-lua').git_commits()
    end, 'fzf'),

    keys.git_bcommits(function()
      require('fzf-lua').git_bcommits()
    end, 'fzf'),

    keys.git_branches(function()
      require('fzf-lua').git_branches()
    end, 'fzf'),

    keys.git_status(function()
      require('fzf-lua').git_status()
    end, 'fzf'),

    keys.git_stash(function()
      require('fzf-lua').git_stash()
    end, 'fzf'),

    keys.reglist(function()
      require('fzf-lua').registers()
    end, 'fzf'),

    keys.bookmarks(function()
      require('fzf-lua').marks({ marks = '%a' })
    end, 'fzf'),

    keys.changed_files(function()
      require('fzf-lua').grep({
        raw_cmd = [[git status -su | rg "^\s*M" | cut -d ' ' -f3 | xargs rg --hidden --column --line-number --no-heading --color=never --with-filename -e '']],
      })
    end, 'fzf'),

    {
      'z=',
      function()
        require('fzf-lua').spell_suggest({
          winopts = {
            width = 0.5,
            height = 0.5,
            preview = { horizontal = 'down:50%' },
          },
        })
      end,
      id = 'fzf_spell_suggest',
      desc = 'Spell suggestions',
      mode = 'n',
    },
  },
}

return P
