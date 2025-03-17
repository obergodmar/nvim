---@type LazySpec
local P = {
  -- Vim and Neovim plugin to reveal the commit messages under the cursor
  'rhysd/git-messenger.vim',
  config = function()
    vim.g['git_messenger_no_default_mappings'] = true
    vim.g['git_messenger_floating_win_opts'] = { border = 'single' }
    vim.g['git_messenger_popup_content_margins'] = false
  end,
  keys = {
    {
      '<leader>B',
      '<cmd>GitMessenger<CR>',
      id = 'git_messenger',
      desc = 'Line [B]lame',
      mode = { 'n', 'v' },
    },
  },
}

return P
