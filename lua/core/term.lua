function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

---@type LazySpec
local P = {
  -- A neovim lua plugin to help easily manage multiple terminal windows
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  ---@type ToggleTermConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    shade_terminals = false,
    start_in_insert = true,
    open_mapping = [[<c-\>]],
    shell = require('helpers.utils').get_shell(),
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end,
}

return P
