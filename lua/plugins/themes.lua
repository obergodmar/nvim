return {
  {
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

              ['GitGraphHash'] = { fg = colors.yellow },
              ['GitGraphTimestamp'] = { fg = colors.green },
              ['GitGraphAuthor'] = { fg = colors.flamingo },
              ['GitGraphBranchName'] = { fg = colors.pink },
              ['GitGraphBranchTag'] = { fg = colors.yellow },
              ['GitGraphBranchMsg'] = { fg = colors.text },

              ['GitGraphBranch1'] = { fg = colors.mauve },
              ['GitGraphBranch2'] = { fg = colors.red },
              ['GitGraphBranch3'] = { fg = colors.peach },
              ['GitGraphBranch4'] = { fg = colors.yellow },
              ['GitGraphBranch5'] = { fg = colors.green },
            }
          end,
        },
      })

      vim.cmd.colorscheme('catppuccin-macchiato')
    end,
  },
  {
    -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
    'obergodmar/kanagawa.nvim',
    branch = 'extra-setup-tmTheme',
    -- enabled = false,
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
      -- vim.cmd.colorscheme(vim.o.background == 'dark' and 'kanagawa-wave' or 'kanagawa-lotus')

      -- vim.api.nvim_create_user_command('KanagawaDark', function()
      --   vim.cmd.colorscheme('kanagawa-wave')
      -- end, { desc = 'Tunr on KanagawaDark theme' })
      --
      -- vim.api.nvim_create_user_command('KanagawaLight', function()
      --   vim.cmd.colorscheme('kanagawa-lotus')
      -- end, { desc = 'Tunr on KanagawaLight theme' })

      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    end,
  },
}
