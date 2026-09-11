local M = {}

function M.flavor()
  local path = vim.fn.expand('~/.config/catppuccin/flavor')
  local file = io.open(path, 'r')
  if not file then
    return 'macchiato'
  end

  local flavor = file:read('*l')
  file:close()

  if flavor == nil or flavor == '' then
    return 'macchiato'
  end

  return flavor
end

return M
