local utils = require('helpers.utils')

if utils.is_neovide() then
  if utils.is_mac() then
    vim.o.guifont = 'Iosevka Nerd Font:b:h16'
  else
    vim.o.guifont = 'Iosevka Nerd Font:b:h12'
  end

  if utils.is_win() then
    vim.g.terminal_color_0 = '#494d64'
    vim.g.terminal_color_1 = '#ed8796'
    vim.g.terminal_color_2 = '#a6da95'
    vim.g.terminal_color_3 = '#eed49f'
    vim.g.terminal_color_4 = '#8aadf4'
    vim.g.terminal_color_5 = '#f5bde6'
    vim.g.terminal_color_6 = '#8bd5ca'
    vim.g.terminal_color_7 = '#b8c0e0'
    vim.g.terminal_color_8 = '#5b6078'
    vim.g.terminal_color_9 = '#ed8796'
    vim.g.terminal_color_10 = '#a6da95'
    vim.g.terminal_color_11 = '#eed49f'
    vim.g.terminal_color_12 = '#8aadf4'
    vim.g.terminal_color_13 = '#f5bde6'
    vim.g.terminal_color_14 = '#8bd5ca'
    vim.g.terminal_color_15 = '#a5adcb'
  end

  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true

  vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', { noremap = true })
  vim.api.nvim_set_keymap('n', '<sc-v>', '"+p', { noremap = true }) -- Paste in normal mode (CTRL+Shift+C)
  vim.api.nvim_set_keymap('v', '<sc-v>', '"+P', { noremap = true })
  vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
  vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>"+p', { noremap = true }) -- Paste in insert mode (CTRL+Shift+C)
  vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+Pi', { noremap = true })

  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  if utils.is_mac() or utils.is_win() then
    vim.g.neovide_scale_factor = 1.0
  else
    -- 0.65 because linux x11 fractonal scaling is enabled and
    -- global scale is 175%
    vim.g.neovide_scale_factor = 0.65
  end

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set('n', '<C-=>', function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set('n', '<C-->', function()
    change_scale_factor(1 / 1.25)
  end)
  vim.keymap.set('n', '<C-0>', function()
    vim.g.neovide_scale_factor = 1.0
  end)
end
