local M = {}

local dependencies = {
  -- Portable package manager for Neovim that runs everywhere Neovim runs.
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  'williamboman/mason.nvim',
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
  'williamboman/mason-lspconfig.nvim',
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        'lazy.nvim',
      },
    },
  },
  {
    'Zeioth/garbage-day.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    opts = {
      aggressive_mode = true,
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {
      hint_prefix = ' ',
    },
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    opts = {
      lightbulb = {
        enable = false,
      },
      ui = {
        devicon = true,
      },
      symbol_in_winbar = {
        enable = false,
        respect_root = true,
      },
      code_action = {
        show_server_name = true,
        extend_gitsigns = true,
      },
    },
    keys = {
      {
        '<leader>ca',
        '<cmd>Lspsaga code_action<CR>',
        id = 'lspsaga_code_action',
        desc = '[C]ode [A]ction',
        mode = { 'n', 'v' },
      },
      {
        '<leader>cr',
        '<cmd>Lspsaga rename<CR>',
        id = 'lspsaga_rename',
        desc = '[R]e[n]ame',
        mode = 'n',
      },
      {
        '<leader>cR',
        '<cmd>Lspsaga rename ++project<CR>',
        id = 'lspsaga_rename_all',
        desc = '[R]e[n]ame Everywhere',
        mode = 'n',
      },
      {
        'K',
        '<cmd>Lspsaga hover_doc<CR>',
        id = 'lspsaga_hover_doc',
        desc = 'Hover documentation',
        mode = 'n',
      },
      {
        '<leader>e',
        '<cmd>Lspsaga show_line_diagnostics<CR>',
        id = 'lspsaga_show_line_diagnostics',
        desc = 'Open floating diagnostic message (current line)',
        mode = 'n',
      },
      {
        '[d',
        '<cmd>Lspsaga diagnostic_jump_prev<CR>',
        id = 'lspsaga_diagnostic_jump_prev',
        desc = 'Go to previous diagnostic message',
        mode = 'n',
      },
      {
        ']d',
        '<cmd>Lspsaga diagnostic_jump_next<CR>',
        id = 'lspsaga_diagnostic_jump_next',
        desc = 'Go to next diagnostic message',
        mode = 'n',
      },
      {
        'ga',
        '<cmd>Lspsaga finder ref+def+imp<CR>',
        id = 'lspsaga_finder_ref_def_imp',
        desc = '[G]oto [A]ll',
        mode = 'n',
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
  },
  {
    -- A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- nvim-cmp source for neovim's built-in language server client.
      'hrsh7th/cmp-nvim-lsp',
      -- nvim-cmp source for buffer words.
      'hrsh7th/cmp-buffer',
      -- nvim-cmp source for filesystem paths.
      'hrsh7th/cmp-path',
      -- nvim-cmp source for commands.
      'hrsh7th/cmp-cmdline',
      -- luasnip completion source for nvim-cmp
      {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
          -- Snippet engine for neovim written in Lua.
          {
            'L3MON4D3/LuaSnip',
            build = (not jit.os:find('Windows')) and 'make install_jsregexp' or nil,
            dependencies = {
              -- Snippets collection for a set of different programming languages.
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
            opts = {
              history = true,
              delete_check_events = 'TextChanged',
            },
          },
        },
      },
      -- This tiny plugin adds vscode-like pictograms to neovim built-in lsp.
      'onsails/lspkind.nvim',
    },
    keys = {},
    config = function()
      local cmp = require('cmp')
      local defaults = require('cmp.config.default')()
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      cmp.setup({
        completion = {
          keyword_length = 1,
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-z>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          -- ['<S-CR>'] = cmp.mapping.confirm({
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'c', 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'c', 'i', 's' }),
        }),
        sources = cmp.config.sources({
          {
            name = 'lazydev',
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer', keyword_length = 4 },
          { name = 'path' },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            menu = {
              nvim_lsp = '[LSP]',
              nvim_lua = '[Lua]',
              path = '[Path]',
              buffer = '[Buffer]',
            },
          }),
        },
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        sorting = defaults.sorting,
        performance = {
          debounce = 0,
          throttle = 0,
          fetching_timeout = 200,
          max_view_entries = 50,
        },
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
  {
    -- Extensible UI for Neovim notifications and LSP progress messages.
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        override_vim_notify = true,
        window = {
          winblend = 0,
        },
      },
      progress = {
        suppress_on_insert = true,
        ignore_done_already = true,
        ignore_empty_message = true,
      },
    },
  },
  require('helpers.lsp.fold').add_ufo_folding(function()
    vim.lsp.buf.hover()
  end),
}

M.nvim_lsp = {
  -- Quickstart configs for Nvim LSP
  'neovim/nvim-lspconfig',
  enabled = not require('helpers.utils').is_coc_instead_of_lspconfig(),
  dependencies = dependencies,
  config = function()
    local servers = {
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
    }

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

    local on_attach = require('helpers.lsp.common').on_attach
    local capabilities = require('helpers.lsp.common').get_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    mason_lspconfig.setup_handlers({
      function(server_name)
        local lspconfig = require('lspconfig')

        local root_dir = nil
        local init_options = nil
        local filetypes = nil
        local commands = nil
        local handlers = nil
        local autostart = true

        if server_name == 'lua_ls' then
          root_dir = lspconfig.util.root_pattern('.git', '*.rockspec')
        end

        lspconfig[server_name].setup({
          settings = servers[server_name],
          capabilities = capabilities,
          on_attach = on_attach,
          root_dir = root_dir,
          init_options = init_options,
          filetypes = filetypes,
          commands = commands,
          autostart = autostart,
          handlers = handlers,
        })
      end,
    })
  end,
  keys = {
    {
      '<leader>R',
      function()
        require('garbage-day.utils').stop_lsp()
      end,
      mode = 'n',
      desc = 'Stop LSP',
      { noremap = true, silent = true },
    },
    {
      '<leader>T',
      function()
        require('garbage-day.utils').start_lsp()
      end,
      mode = 'n',
      desc = 'Start LSP',
      { noremap = true, silent = true },
    },
  },
}

return M
