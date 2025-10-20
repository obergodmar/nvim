---@type LazySpec
local P = {
  'catppuccin/nvim',
  name = 'catppuccin',
  tag = 'v1.11.0',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      term_colors = true,
      integrations = {
        coc_nvim = true,
        fidget = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
      highlight_overrides = {
        all = function(colors)
          return {
            ['@lsp.type.const'] = { fg = colors.peach },
            ['@lsp.typemod.variable.readonly'] = { fg = colors.peach },
            ['@tag.builtin.tsx'] = { fg = colors.blue },
            ['@tag.attribute'] = { fg = colors.yellow },
            ['@tag.attribute.tsx'] = { fg = colors.yellow },
          }
        end,
      },
    })

    vim.cmd.colorscheme('catppuccin-macchiato')
  end,
}

return P
