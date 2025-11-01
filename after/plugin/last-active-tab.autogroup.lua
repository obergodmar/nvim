local last_active_tab_group = vim.api.nvim_create_augroup('LastActiveTab', { clear = true })

vim.api.nvim_create_autocmd('TabLeave', {
  group = last_active_tab_group,
  pattern = '*',
  callback = function()
    vim.g.last_active_tab = vim.fn.tabpagenr()
  end,
})
