local uv = vim.loop
local utils = require('helpers.utils')

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.env.TMUX_PLUGIN_MANAGER_PATH then
      local script = vim.env.TMUX_PLUGIN_MANAGER_PATH .. '/tmux-window-name/scripts/rename_session_windows.py'

      if utils.is_mac() then
        local python = '/etc/profiles/per-user/' .. vim.env.USER .. '/bin/python3'

        if vim.fn.executable(python) == 0 then
          python = vim.fn.exepath('python3')
        end

        uv.spawn(python, { args = { script } })
      else
        uv.spawn(script, {})
      end
    end
  end,
})
