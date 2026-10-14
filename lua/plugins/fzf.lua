local keys = require('helpers.search-keys')

local get_project_root = function()
  local root = vim.fn.systemlist({ 'git', 'rev-parse', '--show-toplevel' })[1]
  if vim.v.shell_error == 0 and root and root ~= '' then
    return root
  end

  return vim.fn.getcwd()
end

local build_fd_file_search_cmd = function()
  local root = vim.fn.shellescape(get_project_root())
  local cmd

  if require('helpers.utils').is_win() then
    cmd = 'fd --absolute-path . ' .. root .. ' --color=never --type f --hidden --follow --exclude .git 2> nul'
  else
    cmd = 'fd --absolute-path . ' .. root .. ' --color=never --type f --hidden --follow --exclude .git 2> /dev/null'
  end

  return cmd
end

---@type LazySpec
local P = {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    'fzf-native',
    fzf_colors = true,
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
    defaults = {
      absolute_path = true,
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
        cwd_prompt = false,
        cmd = build_fd_file_search_cmd(),
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
        cwd_prompt = false,
        cmd = build_fd_file_search_cmd(),
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
