---@type LazySpec
local P = {
  -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  'rebelot/kanagawa.nvim',
  enabled = false,
  opts = {
    theme = 'wave',
    undercurl = true,
    keywordStyle = { italic = true },
    commentStyle = { italic = true },
    statementStyle = { bold = true },
    background = {
      dark = 'wave',
      light = 'lotus',
    },
    overrides = function(colors)
      local theme = colors.theme

      return {
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme(vim.o.background == 'dark' and 'kanagawa-wave' or 'kanagawa-lotus')

    vim.api.nvim_create_user_command('KanagawaDark', function()
      vim.cmd.colorscheme('kanagawa-wave')
    end, { desc = 'Tunr on KanagawaDark theme' })

    vim.api.nvim_create_user_command('KanagawaLight', function()
      vim.cmd.colorscheme('kanagawa-lotus')
    end, { desc = 'Tunr on KanagawaLight theme' })

    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
  end,
}

return P
