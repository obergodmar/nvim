local M = {}

---@return boolean
function M.is_win()
  return vim.fn.has('win32') == 1
end

---@return boolean
function M.is_mac()
---@diagnostic disable-next-line: undefined-global
  return jit.os == 'OSX'
end

---@return boolean
function M.is_neovide()
  return vim.g.neovide
end

---@return string
function M.get_shell()
  local pwsh = 'pwsh.exe -nologo -WorkingDirectory ' .. vim.loop.cwd()

  if M.is_win() then
    return vim.fn.executable('pwsh') and pwsh or 'powershell.exe'
  end

  return vim.shell
end

function M.foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == '' then
      return '0'
    end

    vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or '0'
end

function M.is_coc_instead_of_lspconfig()
  return true
end

return M
