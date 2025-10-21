local auto_spell_group = vim.api.nvim_create_augroup('AutoSpell', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = auto_spell_group,
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    if require('helpers.utils').is_coc_instead_of_lspconfig() then
      return
    end

    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'ru,en'
  end,
})
