return {
  { 'tpope/vim-fugitive', event = 'VeryLazy' },
  {
    'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = { 'tpope/vim-fugitive' },
  },
  {
    -- Vim and Neovim plugin to reveal the commit messages under the cursor
    'rhysd/git-messenger.vim',
    config = function()
      vim.g['git_messenger_no_default_mappings'] = true
      vim.g['git_messenger_floating_win_opts'] = { border = 'single' }
      vim.g['git_messenger_popup_content_margins'] = false
    end,
    keys = {
      {
        '<leader>B',
        '<cmd>GitMessenger<CR>',
        id = 'git_messenger',
        desc = 'Line [B]lame',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    -- Git integration for buffers
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      attach_to_untracked = true,
      signcolumn = true,
      numhl = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '[gitsigns] Next Hunk' })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '[gitsigns] Prev Hunk' })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = '[gitsigns] Stage Hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = '[gitsigns] Reset Hunk' })
        map('v', '<leader>hs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = '[gitsigns] Stage Hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = '[gitsigns] Reset Hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = '[gitsigns] Stage Buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = '[gitsigns] Undo Stage Hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = '[gitsigns] Reset Buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = '[gitsigns] Preview Hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line({ full = true })
        end, { desc = '[gitsigns] Blame Line' })
        map('n', '<leader>hd', gs.diffthis, { desc = '[gitsigns] Diffthis' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = '[gitsigns] Toggle Deleted' })
      end,
    },
  },
}
