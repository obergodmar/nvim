local function format()
  if
    require('helpers.utils').is_coc_instead_of_lspconfig()
    and vim.fn.exists('*CocAction') == 1
    and vim.fn['coc#rpc#ready']() == 1
    -- LuaLS advertises formatting even when its formatter is disabled.
    and (vim.bo.filetype ~= 'lua' or vim.fn.CocAction('getConfig', 'Lua.format').enable ~= false)
    and vim.fn.CocAction('hasProvider', 'format')
  then
    vim.fn.CocAction('format')
  else
    require('conform').format({ async = false })
  end
end

---@type LazySpec
local P = {
  -- A format runner for Neovim.
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  cmd = {
    'ConformInfo',
    'ConformFormat',
    'ConformFormatWrite',
    'Format',
    'FormatWrite',
  },
  keys = {
    {
      '<leader>f',
      function()
        format()
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

    vim.api.nvim_create_user_command('ConformFormat', function()
      conform.format({ async = false })
    end, {})

    vim.api.nvim_create_user_command('ConformFormatWrite', function()
      conform.format({ async = false })
      vim.cmd.write()
    end, {})

    vim.api.nvim_create_user_command('Format', function()
      format()
    end, {})

    vim.api.nvim_create_user_command('FormatWrite', function()
      format()
      vim.cmd.write()
    end, {})
  end,
}

return P
