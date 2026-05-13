local ts = vim.api.nvim_create_augroup('ts-highlight', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = ts,
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
