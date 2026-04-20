local copilot_filetypes = {
  lua = true,
  nix = true,
  sh = true,
  bash = true,
  zsh = true,
  json = true,
  jsonc = true,
  xml = true,
  css = true,
  html = true,
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  svelte = true,
  vue = true,
  php = true,
  go = true,
  rust = true,
  c = true,
  cpp = true,
  ['*'] = false,
}

local function is_copilot_filetype_enabled()
  local filetype = vim.bo.filetype
  local short_filetype = filetype:gsub('%..*', '')

  return copilot_filetypes[filetype] == true or copilot_filetypes[short_filetype] == true
end

local function toggle_copilot()
  if package.loaded['copilot'] and not require('copilot.client').is_disabled() then
    require('copilot.command').disable()
    vim.notify('Copilot disabled', vim.log.levels.INFO)
    return
  end

  if not is_copilot_filetype_enabled() then
    vim.notify('Copilot not enabled for filetype: ' .. vim.bo.filetype, vim.log.levels.WARN)
    return
  end

  require('lazy').load({ plugins = { 'copilot.lua' } })

  local command = require('copilot.command')

  if require('copilot.client').is_disabled() then
    local should_attach, no_attach_reason = require('copilot.util').should_attach(0)

    if not should_attach then
      vim.notify('Copilot not enabled: ' .. no_attach_reason, vim.log.levels.WARN)
      return
    end

    command.enable()
  end

  command.attach()
  vim.notify('Copilot enabled', vim.log.levels.INFO)
end

return {
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    dependencies = {
      {
        'copilotlsp-nvim/copilot-lsp',
        init = function()
          vim.g.copilot_nes_debounce = 500
        end,
      },
    },
    init = function()
      vim.keymap.set('n', '<leader>C', toggle_copilot, { desc = 'Toggle Copilot' })
      vim.keymap.set('n', '<leader>С', toggle_copilot, { desc = 'Toggle Copilot' })
    end,
    opts = {
      filetypes = copilot_filetypes,
      panel = {
        enabled = false,
      },
      nes = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept_and_goto = '<C-x>',
          accept = false,
          dismiss = '<C-c>',
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<S-Tab>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      telemetry = {
        telemetryLevel = 'off',
      },
    },
    config = function(_, opts)
      vim.g.copilot_no_tab_map = true
      -- vim.g.copilot_proxy = '127.0.0.1:12334'

      require('copilot').setup(opts)
    end,
  },
}
