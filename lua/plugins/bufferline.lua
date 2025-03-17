local function mapBufferlineKeys(goToIndex)
  return {
    '<leader>' .. goToIndex,
    '<cmd>lua require("bufferline").go_to(' .. goToIndex .. ', true)<cr>',
    id = 'bufferline_go_to_' .. goToIndex,
    desc = 'Go to ' .. goToIndex .. ' tab',
    mode = 'n',
  }
end

local keys = {}
for i = 1, 9, 1 do
  table.insert(keys, mapBufferlineKeys(i))
end

---@type LazySpec
local P = {
  -- Tabs replacer
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'BufEnter',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    ---@type bufferline.Options
    ---@diagnostic disable-next-line: missing-fields
    options = {
      mode = 'tabs',
      numbers = 'ordinal',
      indicator = { style = 'underline' },
      -- diagnostics = require('helpers.utils').is_coc_instead_of_lspconfig() and 'coc' or 'nvim_lsp',
      diagnostics = nil,
      color_icons = true,
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_duplicate_prefix = false,
      show_close_icon = false,
      separator_style = 'thin',
      modified_icon = '[+]',
      offsets = {
        {
          filetype = 'NvimTree',
          text_align = 'center',
          separator = true,
        },
      },
    },
  },
  keys = keys,
}

return P
