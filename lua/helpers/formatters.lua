local M = {}

local utils = require('helpers.utils')

function M.get_formatters_by_ft()
  local formatters_by_ft = {
    lua = { 'stylua' },
    json = { 'prettier' },
    xml = { 'xmllint' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    zsh = { 'shfmt' },
    jsonc = { 'prettier' },
    markdown = { 'mdformat' },
    css = { 'prettier' },
    html = { 'prettier' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    svelte = { 'prettier' },
    vue = { 'prettier' },
    php = { 'php_cs_fixer' },
    go = { 'gofmt' },
    rust = { 'rustfmt' },
    nix = { 'nixfmt' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    python = { 'ruff_format' },
  }

  -- sed on Windows works differently, same as the old formatter.nvim config.
  if not utils.is_win() then
    formatters_by_ft['*'] = { 'trim_whitespace' }
  end

  return formatters_by_ft
end

return M
