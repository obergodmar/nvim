return {
  ---@type LazySpec
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          multiwindow = true,
          multiline_threshold = 1,
          mode = 'topline',
        },
      },
    },

    config = function()
      local treesitter = require('nvim-treesitter')
      local parsers = {
        'bash',
        'c',
        'c_sharp',
        'clojure',
        'cmake',
        'comment',
        'cpp',
        'css',
        'csv',
        'dart',
        'desktop',
        'diff',
        'dockerfile',
        'ecma',
        'editorconfig',
        'elixir',
        'erlang',
        'git_config',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'graphql',
        'groovy',
        'haskell',
        'hcl',
        'html',
        'http',
        'ini',
        'java',
        'javascript',
        'jq',
        'json',
        'json5',
        'jsx',
        'just',
        'kdl',
        'kotlin',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'nginx',
        'nix',
        'ocaml',
        'passwd',
        'php',
        'prisma',
        'properties',
        'python',
        'query',
        'regex',
        'ruby',
        'rust',
        'scss',
        'sql',
        'ssh_config',
        'svelte',
        'swift',
        'terraform',
        'toml',
        'tsx',
        'typescript',
        'udev',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
        'zig',
      }

      treesitter.setup({})
      local install_task = treesitter.install(parsers)

      vim.filetype.add({
        extension = {
          cfg = 'cfg',
          conf = 'conf',
        },
      })
      vim.treesitter.language.register('ini', { 'cfg', 'conf' })

      local available_parsers = {}
      for _, parser in ipairs(treesitter.get_available()) do
        available_parsers[parser] = true
      end

      local installing = {}

      local function restart_treesitter(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        pcall(vim.treesitter.stop, buf)
        pcall(vim.treesitter.start, buf, lang)
      end

      local function start_or_install(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang or not available_parsers[lang] then
          return
        end

        if pcall(vim.treesitter.start, args.buf, lang) or installing[lang] then
          return
        end

        installing[lang] = true
        treesitter.install({ lang }):await(function(err, ok)
          installing[lang] = nil
          if err or not ok then
            return
          end

          vim.schedule(function()
            restart_treesitter(args.buf, lang)
          end)
        end)
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('ts-auto-install', { clear = true }),
        callback = start_or_install,
      })

      install_task:await(function(err, ok)
        if err or not ok then
          return
        end

        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
            if available_parsers[lang] then
              restart_treesitter(buf, lang)
            end
          end
        end)
      end)

      local ts_move = require('nvim-treesitter-textobjects.move')
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        ts_move.goto_next('@function.outer', 'textobjects')
      end, { desc = 'Next function boundary' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        ts_move.goto_previous('@function.outer', 'textobjects')
      end, { desc = 'Previous function boundary' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
        ts_move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
        ts_move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']p', function()
        ts_move.goto_next_start('@parameter.inner', 'textobjects')
      end, { desc = 'Next parameter' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[p', function()
        ts_move.goto_previous_start('@parameter.inner', 'textobjects')
      end, { desc = 'Previous parameter' })

      -- Repeat moves with ;,
      local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
    end,
  },
}
