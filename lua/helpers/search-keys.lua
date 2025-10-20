---@type { [string]: fun(fn: function, name: string): table }
local keys = {
  oldfiles = function(fn, name)
    return {
      '<leader>?',
      fn,
      id = name .. '_oldfiles',
      desc = '[?] Find recently opened files',
      mode = 'n',
    }
  end,
  buffers = function(fn, name)
    return {
      '<leader><space>',
      fn,
      id = name .. '_buffers',
      desc = '[ ] Find existing buffers',
      mode = 'n',
    }
  end,
  resume = function(fn, name)
    return {
      '<leader>/',
      fn,
      id = name .. '_resume_search',
      desc = '[/] Previous picker',
      mode = 'n',
    }
  end,
  find_files = function(fn, name)
    return {
      '<leader>sf',
      fn,
      id = name .. '_files',
      desc = '[S]earch [F]iles',
      mode = 'n',
    }
  end,
  grep_string = function(fn, name)
    return {
      '<leader>sg',
      fn,
      id = name .. '_grep_string',
      desc = '[S]earch [g]rep',
      mode = 'n',
    }
  end,
  live_grep = function(fn, name)
    return {
      '<leader>sG',
      fn,
      id = name .. '_live_grep',
      desc = '[S]earch Live [G]rep',
      mode = 'n',
    }
  end,
  live_grep_args = function(fn, name)
    return {
      '<leader>sa',
      fn,
      id = name .. '_live_grep_args',
      desc = '[S]earch Live Grep ([A]rgs)',
      mode = 'n',
    }
  end,
  git_files = function(fn, name)
    return {
      '<leader>gf',
      fn,
      id = name .. '_git_files',
      desc = 'Search [G]it [F]iles',
      mode = 'n',
    }
  end,
  git_commits = function(fn, name)
    return {
      '<leader>sc',
      fn,
      id = name .. '_git_commits',
      desc = '[S]earch [C]ommits',
      mode = 'n',
    }
  end,
  git_bcommits = function(fn, name)
    return {
      '<leader>sC',
      fn,
      id = name .. '_git_buffer_commits',
      desc = '[S]earch Buffer [C]ommits',
      mode = 'n',
    }
  end,
  git_branches = function(fn, name)
    return {
      '<leader>sb',
      fn,
      id = name .. '_git_branches',
      desc = '[S]earch [B]ranches',
      mode = 'n',
    }
  end,
  git_status = function(fn, name)
    return {
      '<leader>ss',
      fn,
      id = name .. '_git_status',
      desc = '[S]earch Git [S]tatus',
      mode = 'n',
    }
  end,
  git_stash = function(fn, name)
    return {
      '<leader>sS',
      fn,
      id = name .. '_git_stash',
      desc = '[S]earch Git [S]tash',
      mode = 'n',
    }
  end,
  lsp_references = function(fn, name)
    return {
      'gr',
      fn,
      id = name .. '_refs',
      desc = '[G]oto [R]eferences',
      mode = 'n',
    }
  end,
  lsp_definitions = function(fn, name)
    return {
      'gd',
      fn,
      id = name .. '_defs',
      desc = '[G]oto [D]efinitions',
      mode = 'n',
    }
  end,
  lsp_implementations = function(fn, name)
    return {
      'gI',
      fn,
      id = name .. '_impls',
      desc = '[G]oto [I]mplementations',
      mode = 'n',
    }
  end,
  file_diagnostics = function(fn, name)
    return {
      '<leader>sd',
      fn,
      id = name .. '_file_diagnostics',
      desc = '[S]earch [D]iagnostics',
      mode = 'n',
    }
  end,
  project_diagnostics = function(fn, name)
    return {
      '<leader>sD',
      fn,
      id = name .. '_workspace_diagnostics',
      desc = '[S]earch [D]iagnostics',
      mode = 'n',
    }
  end,
  quicklist = function(fn, name)
    return {
      '<leader>sq',
      fn,
      id = name .. '_quickfix',
      desc = '[S]how [Q]uick List',
      mode = 'n',
    }
  end,
  reglist = function(fn, name)
    return {
      '<leader>sr',
      fn,
      id = name .. '_reglist',
      desc = '[S]how [R]eg List',
      mode = 'n',
    }
  end,
  changed_files = function(fn, name)
    return {
      '<leader>sx',
      fn,
      id = name .. '_changed_files',
      desc = '[S]earch in [C]hanged [F]iles',
      mode = 'n',
    }
  end,
  bookmarks = function(fn, name)
    return {
      '<leader>sm',
      fn,
      id = name .. '_bookmarks',
      desc = '[S]earch [M]arks',
      mode = 'n',
    }
  end,
}

return keys
