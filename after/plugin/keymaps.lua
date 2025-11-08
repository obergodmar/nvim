local map = vim.keymap.set

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
map('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
map('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-Left>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-Down>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-Up>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-Right>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<M-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height', remap = true })
map('n', '<M-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height', remap = true })
map('n', '<M-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width', remap = true })
map('n', '<M-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width', remap = true })

map('n', '<leader>ta', ':$tabnew<CR>', { noremap = true, desc = '[T]ab [A]dd' })
map('n', '<leader>tc', ':tabclose<CR>', { noremap = true, desc = '[T]ab [C]lose' })
map('n', '<leader>to', ':tabonly<CR>', { noremap = true, desc = '[T]ab [O]nly (Close other tabs)' })
map('n', '<leader>tn', ':tabn<CR>', { noremap = true, desc = '[T]ab [N]ext' })
map('n', '<leader>tp', ':tabp<CR>', { noremap = true, desc = '[Tab] [P]revious' })
-- move current tab to previous position
map('n', '<leader>tmp', ':-tabmove<CR>', { noremap = true, desc = '[T]ab [M]ove to [P]revious position' })
-- move current tab to next position
map('n', '<leader>tmn', ':+tabmove<CR>', { noremap = true, desc = '[Tab] [M]ove to [N]ext position ' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- copy file path
--relative path
map('n', '<leader>cp', '<cmd>let @+ = expand("%")<cr>', { desc = '[C]opy relative [P]ath' })

--relatuve path with line number
map(
  'n',
  '<leader>cl',
  '<cmd>let @+ = expand("%") . ":" . line(".")<cr>',
  { desc = '[C]opy relative path with [L]ine number' }
)

--full path
map('n', '<leader>cf', '<cmd>let @+ = expand("%:p")<cr>', { desc = '[C]opy [F]ull path' })

--just filename
map('n', '<leader>cn', '<cmd>:let @+ = expand("%:t")<cr>', { desc = '[C]opy file [N]ame' })

map('n', '<PageUp>', '', { silent = true })
map('n', '<PageDown>', '', { silent = true })

map('n', '<S-Up>', 'v<Up>', { silent = true })
map('n', '<S-Right>', 'v<Right>', { silent = true })
map('n', '<S-Down>', 'v<Down>', { silent = true })
map('n', '<S-Left>', 'v<Left>', { silent = true })

map({ 'v', 'i' }, '<S-Up>', '<Up>', { silent = true })
map({ 'v', 'i' }, '<S-Right>', '<Right>', { silent = true })
map({ 'v', 'i' }, '<S-Down>', '<Down>', { silent = true })
map({ 'v', 'i' }, '<S-Left>', '<Left>', { silent = true })

map({ 'n', 'v' }, '<leader>y', '"+y', { silent = true })
map({ 'n', 'v' }, '<leader>Y', '"+yg_', { silent = true })
map({ 'n', 'v' }, '<leader>н', '"+y', { silent = true })
map({ 'n', 'v' }, '<leader>Н', '"+yg_', { silent = true })

map({ 'n', 'v' }, '<leader>p', '"+p', { silent = true })
map({ 'n', 'v' }, '<leader>P', '"+P', { silent = true })
map({ 'n', 'v' }, '<leader>з', '"+p', { silent = true })
map({ 'n', 'v' }, '<leader>З', '"+P', { silent = true })

map({ 'n', 'v' }, '<M-p>', '"0p', { silent = true })
map({ 'n', 'v' }, '<M-P>', '"0P', { silent = true })
map({ 'n', 'v' }, '<M-з>', '"0p', { silent = true })
map({ 'n', 'v' }, '<M-З>', '"0P', { silent = true })


---@return string|string[]|nil
local function get_last_search()
  local last_search = vim.fn.getreg('/')
  if not last_search then
    print('There is no last search')

    return nil
  end

  return last_search
end

local function toggle_highlighting()
  local current_word = vim.fn.expand('<cword>')
  local last_search = get_last_search()

  local new_hls = not (vim.v.hlsearch == 1 and current_word == last_search)

  pcall(vim.fn.setreg, '/', current_word)

  vim.opt.hls = new_hls
end

local map = vim.keymap.set

map('n', '<cr>', toggle_highlighting, { remap = true, desc = 'Highlight word under cursor' })

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- map({ 'n', 'i', 'v' }, '<ScrollWheelUp>', '<Nop>', { noremap = true, silent = true })
-- map({ 'n', 'i', 'v' }, '<ScrollWheelDown>', '<Nop>', { noremap = true, silent = true })
