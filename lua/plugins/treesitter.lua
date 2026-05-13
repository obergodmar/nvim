return {
  ---@type LazySpec
  {
    --- A lightweight Tree-sitter parser manager for Neovim.
    'romus204/tree-sitter-manager.nvim',
    dependencies = {},
    config = function()
      require('tree-sitter-manager').setup({
        ensure_installed = {
          'gitcommit',
          'markdown',
          'markdown_inline',
          'regex',
          'lua',
          'vim',
          'bash',
          'comment',
          'nix',
        }, -- list of parsers to install at the start of a neovim session
        auto_install = true, -- if enabled, install missing parsers when editing a new file
        highlight = true, -- treesitter highlighting is enabled by default
      })
    end,
  },
}
