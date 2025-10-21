vim.api.nvim_create_user_command('BufOnly', function()
  pcall(vim.api.nvim_command, "exec '%bd|e#|bd#'")
end, {})

vim.api.nvim_create_user_command('Q', function()
  pcall(vim.api.nvim_command, 'q')
end, {})

vim.api.nvim_create_user_command('Qa', function()
  pcall(vim.api.nvim_command, 'qa')
end, {})

vim.api.nvim_create_user_command('QA', function()
  pcall(vim.api.nvim_command, 'qa')
end, {})

vim.api.nvim_create_user_command('W', function()
  pcall(vim.api.nvim_command, 'w')
end, {})

vim.api.nvim_create_user_command('Wq', function()
  pcall(vim.api.nvim_command, 'wq')
end, {})

vim.api.nvim_create_user_command('WQ', function()
  pcall(vim.api.nvim_command, 'wq')
end, {})

vim.api.nvim_create_user_command('Logs', function()
  vim.cmd('redir @e | silent! messages | redir END')
  vim.cmd('enew')
  vim.cmd('put e')
end, {})
