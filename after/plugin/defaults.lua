local utils = require('helpers.utils')

local opt = vim.opt
local g = vim.g

opt.mouse = 'a' -- Enable mouse mode
opt.mousemoveevent = true
vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[aunmenu PopUp.-1-]])

opt.inccommand = 'split'
opt.smarttab = true
opt.backspace = { 'start', 'eol', 'indent' }
opt.title = true
opt.titlestring = '%F'
opt.cursorline = true
opt.cursorlineopt = 'number,screenline'
opt.expandtab = true -- Use spaces instead of tabs
opt.pumblend = 10 -- Popup blend
-- opt.breakindent = true -- Enable break indent
opt.shiftround = true -- Round indent
-- opt.shiftwidth = 2 -- Size of an indent
opt.swapfile = true
opt.undofile = true -- Save undo history
opt.ignorecase = true
opt.sidescrolloff = 16 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spell = false
opt.spelllang = { 'en', 'ru' }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
-- opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 500
opt.completeopt = 'menuone,noselect'
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

opt.hidden = true
opt.backup = false
opt.writebackup = false

opt.scrolloff = 8
opt.smoothscroll = true
opt.sidescrolloff = 16

-- opt.shada = "!,'10000,<10000,s100,h,f1"

opt.fileencodings = 'utf-8,cp1251'

if utils.is_mac() then
  opt.rtp:append('/opt/homebrew/opt/fzf')
end

opt.lazyredraw = false
opt.showcmdloc = 'statusline'

if utils.is_win() then
  vim.api.nvim_exec('language en_US', true)
  opt.ff = 'unix'
else
  opt.shell = 'bash'
end

opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Fix markdown indentation settings
g.markdown_recommended_style = 0

opt.list = true
opt.listchars:append('trail:⋅')

opt.foldlevel = 99
opt.foldexpr = "v:lua.require'helpers.utils'.foldexpr()"
opt.foldmethod = 'expr'
opt.foldtext = ''

opt.sessionoptions="blank,buffers,curdir,tabpages,winsize,winpos,localoptions"

