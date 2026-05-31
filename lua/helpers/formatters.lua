local M = {}

local root_config = require('helpers.root-config')
local utils = require('helpers.utils')

local prettier_config_files = {
  '.prettierrc',
  '.prettierrc.json',
  '.prettierrc.json5',
  '.prettierrc.yaml',
  '.prettierrc.yml',
  '.prettierrc.toml',
  '.prettierrc.js',
  '.prettierrc.cjs',
  '.prettierrc.mjs',
  '.prettierrc.ts',
  '.prettierrc.cts',
  '.prettierrc.mts',
  'prettier.config.js',
  'prettier.config.cjs',
  'prettier.config.mjs',
  'prettier.config.ts',
  'prettier.config.cts',
  'prettier.config.mts',
}

local oxfmt_config_files = {
  '.oxfmt.conf',
  '.oxfmtrc',
  '.oxfmtrc.json',
  '.oxfmtrc.jsonc',
  'oxfmt.json',
  'oxfmt.config.ts',
  'vite.config.ts',
  'vite.config.js',
}

local function web_formatters(bufnr)
  if root_config.exists(oxfmt_config_files, { bufnr = bufnr }) then
    return { 'oxfmt' }
  end

  if root_config.exists(prettier_config_files, { bufnr = bufnr }) then
    return { 'prettier' }
  end

  return { 'prettier' }
end

function M.get_formatters_by_ft()
  local formatters_by_ft = {
    lua = { 'stylua' },
    json = web_formatters,
    xml = { 'xmllint' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    zsh = { 'shfmt' },
    jsonc = web_formatters,
    markdown = { 'mdformat' },
    css = web_formatters,
    html = web_formatters,
    javascript = web_formatters,
    javascriptreact = web_formatters,
    typescript = web_formatters,
    typescriptreact = web_formatters,
    svelte = web_formatters,
    vue = web_formatters,
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
