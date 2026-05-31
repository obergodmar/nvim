---@type LazySpec
local P = {
  -- A format runner for Neovim.
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  cmd = {
    'ConformInfo',
    'Format',
    'FormatWrite',
  },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = false })
        vim.cmd.write()
      end,
      id = 'format_file',
      desc = '[F]ormat file',
      mode = 'n',
    },
  },
  config = function()
    local conform = require('conform')

    conform.setup({
      log_level = vim.log.levels.WARN,
      formatters_by_ft = require('helpers.formatters').get_formatters_by_ft(),
      default_format_opts = {
        timeout_ms = 3000,
        lsp_format = 'never',
      },
      notify_on_error = true,
    })

    vim.api.nvim_create_user_command('Format', function()
      conform.format({ async = false })
    end, {})

    vim.api.nvim_create_user_command('FormatWrite', function()
      conform.format({ async = false })
      vim.cmd.write()
    end, {})
  end,
}

return P
