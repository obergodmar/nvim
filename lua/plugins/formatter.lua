---@type LazySpec
local P = {
  -- A format runner for Neovim.
  'obergodmar/formatter.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>f',
      ':FormatWrite<CR>',
      id = 'format_file',
      desc = '[F]ormat file',
      mode = 'n',
    },
  },
  config = function()
    require('formatter').setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = require('helpers.formatter.default-formatters').getFormatters(),
    })
  end,
}

return P
