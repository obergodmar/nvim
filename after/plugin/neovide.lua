local utils = require('helpers.utils')

if utils.is_neovide() then
  if utils.is_mac() then
    vim.o.guifont = 'Iosevka Nerd Font:h13.5'
    vim.g.neovide_input_macos_option_key_is_meta = 'both'
  else
    vim.o.guifont = 'Iosevka Nerd Font:b:h12'
  end

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

  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_text_gamma = 0.0
  vim.g.neovide_text_contrast = 0.0
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_underline_stroke_scale = 2.0
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true
  vim.g.experimental_layer_grouping = true

  vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', { noremap = true })
  vim.api.nvim_set_keymap('v', '<sc-с>', '"+y', { noremap = true })

  vim.api.nvim_set_keymap('n', '<sc-v>', '"+p', { noremap = true })
  vim.api.nvim_set_keymap('n', '<sc-м>', '"+p', { noremap = true })

  vim.api.nvim_set_keymap('v', '<sc-v>', '"+p', { noremap = true })
  vim.api.nvim_set_keymap('v', '<sc-м>', '"+p', { noremap = true })

  vim.api.nvim_set_keymap('c', '<sc-v>', '<C-r>+', { noremap = true })
  vim.api.nvim_set_keymap('c', '<sc-м>', '<C-r>+', { noremap = true })

  vim.api.nvim_set_keymap('i', '<sc-v>', '<C-r>+', { noremap = true })
  vim.api.nvim_set_keymap('i', '<sc-м>', '<C-r>+', { noremap = true })

  vim.api.nvim_set_keymap('t', '<sc-v>', '<C-\\><C-n>"+pi', { noremap = true })
  vim.api.nvim_set_keymap('t', '<sc-м>', '<C-\\><C-n>"+pi', { noremap = true })

  if utils.is_mac() then
    vim.keymap.set('v', '<D-c>', '"+y')
    vim.keymap.set('n', '<D-v>', '"+p')
    vim.keymap.set('v', '<D-v>', '"+p')
    vim.keymap.set('c', '<D-v>', '<C-r>+')
    vim.keymap.set('i', '<D-v>', '<C-r>+')

    vim.keymap.set('v', '<D-с>', '"+y')
    vim.keymap.set('n', '<D-м>', '"+p')
    vim.keymap.set('v', '<D-м>', '"+p')
    vim.keymap.set('c', '<D-м>', '<C-r>+')
    vim.keymap.set('i', '<D-м>', '<C-r>+')
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
