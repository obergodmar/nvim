local M = {}

M.add_ufo_folding = function(hoverFn)
  local create_fold_virt_text = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local totalLines = vim.api.nvim_buf_line_count(0)
    local foldedLines = endLnum - lnum
    local suffix = (' 󰁂 %d %d%%'):format(foldedLines, foldedLines / totalLines * 100)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    local rAlignAppndx = math.max(math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth, 0)
    suffix = (' '):rep(rAlignAppndx) .. suffix
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
  end

  local ftMap = {
    css = { 'treesitter', 'indent' },
    php = { 'treesitter', 'indent' },
    markdown = { 'treesitter' },
    git = '',
  }

  return {
    -- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
    'kevinhwang91/nvim-ufo',
    dependencies = {
      -- The goal of promise-async is to port Promise & Async from JavaScript to Lua.
      'kevinhwang91/promise-async',

      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require('statuscol.builtin')
          require('statuscol').setup({
            relculright = true,
            setopt = true,
            segments = {
              {
                sign = {
                  name = { '.*' },
                  text = { '.*' },
                  namespace = { 'coc-diagnostic' },
                  maxwidth = 1,
                  colwidth = 2,
                },
              },
              {
                text = { builtin.lnumfunc, " " },
              },
              {
                sign = {
                  namespace = { 'gitsigns' },
                  maxwidth = 1,
                  colwidth = 1,
                },
              },
              {
                text = {
                  '%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " ") : " " }',
                  ' ',
                },
                hl = 'FoldColumn',
                sign = {
                  name = { '.*' },
                  fillchar = ' ',
                  fillcharhl = nil,
                },
              },
            },
          })
        end,
      },
    },
    keys = {
      {
        'K',
        hoverFn,
        id = 'ufo_hover_doc',
        desc = 'Hover fold',
        mode = 'n',
      },
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        id = 'ufo_open_all_folds',
        desc = 'Open All Folds',
        mode = 'n',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        id = 'ufo_close_all_folds',
        desc = 'Close All Folds',
        mode = 'n',
      },
      {
        'zU',
        function()
          require('ufo').enableFold()
        end,
        id = 'ufo_enable_fold',
        desc = 'Enable Fold for buffer',
        mode = 'n',
      },
    },
    opts = {
      open_fold_hl_timeout = 400,
      close_fold_kinds = {},
      enable_get_fold_virt_text = true,
      fold_virt_text_handler = create_fold_virt_text,
      provider_selector = function(_, filetype)
        return ftMap[filetype]
      end,
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
    },
  }
end

return M
