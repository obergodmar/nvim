local on_attach = require('helpers.lsp.common').on_attach

local servers = {
  typos_lsp = {},
  bashls = {},
}

---@type LazyPluginSpec
local P = {
  -- Quickstart configs for Nvim LSP
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    'williamboman/mason.nvim',
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    'williamboman/mason-lspconfig.nvim',
      },
  config = function()
    local capabilities = require('helpers.lsp.common').get_capabilities()

    require('mason').setup({
      ui = {
        width = 1.0,
        height = 1.0,
      },
    })

    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        local lspconfig = require('lspconfig')
        lspconfig[server_name].setup({
          settings = servers[server_name],
          capabilities = capabilities,
          on_attach = on_attach,
        })

        vim.diagnostic.config({
          virtual_text = {
            format = function(diagnostic)
              local lsp = diagnostic.source or 'Unknown'
              return string.format('[%s] %s', lsp, diagnostic.message)
            end,
          },
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        })
      end,
    })
  end,
  keys = {
    {
      '<leader>R',
      ':LspStop<CR>',
      mode = 'n',
      desc = 'Stop LSP',
      { noremap = true, silent = true },
    },
    {
      '<leader>T',
      ':LspStart<CR>',
      mode = 'n',
      desc = 'Start LSP',
      { noremap = true, silent = true },
    },
    {
      '<leader>e',
      function()
        vim.diagnostic.open_float(nil, {
          focusable = true,
          format = function(diagnostic)
            local lsp = diagnostic.source or 'Unknown'
            return string.format('[%s] %s', lsp, diagnostic.message)
          end,
        })
      end,
      mode = 'n',
      desc = 'Open diagnostics',
      { noremap = true, silent = true },
    },
    {
      'cr',
      function()
        local cmdId
        cmdId = vim.api.nvim_create_autocmd({ 'CmdlineEnter' }, {
          callback = function()
            local key = vim.api.nvim_replace_termcodes('<C-f>', true, false, true)
            vim.api.nvim_feedkeys(key, 'c', false)
            vim.api.nvim_feedkeys('0', 'n', false)
            cmdId = nil
            return true
          end,
        })
        vim.lsp.buf.rename()
        -- if LPS couldn't trigger rename on the symbol, clear the autocmd
        vim.defer_fn(function()
          -- the cmdId is not nil only if the LSP failed to rename
          if cmdId then
            vim.api.nvim_del_autocmd(cmdId)
          end
        end, 500)
      end,
      mode = 'n',
      desc = 'Rename symbol',
      { noremap = true, silent = true },
    },
  },
}

return P
