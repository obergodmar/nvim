return {
  getFormatters = function()
    local formatters = {
      lua = {
        require('formatter.filetypes.lua').stylua,
      },
      json = {
        require('formatter.filetypes.json').prettier,
      },
      xml = {
        require('formatter.filetypes.xml').xmllint,
      },
      sh = {
        require('formatter.filetypes.sh').shfmt,
      },
      bash = {
        require('formatter.filetypes.sh').shfmt,
      },
      zsh = {
        require('formatter.filetypes.sh').shfmt,
      },
      jsonc = {
        require('formatter.filetypes.json').prettier,
      },
      markdown = {
        require('formatter.filetypes.markdown').mdformat,
      },
      css = {
        require('formatter.filetypes.css').prettier,
      },
      html = {
        require('formatter.filetypes.html').prettier,
      },
      javascript = {
        require('formatter.filetypes.javascript').prettier,
      },
      javascriptreact = {
        require('formatter.filetypes.javascriptreact').prettier,
      },
      typescript = {
        require('formatter.filetypes.typescript').prettier,
      },
      typescriptreact = {
        require('formatter.filetypes.typescriptreact').prettier,
      },
      svelte = {
        require('formatter.filetypes.svelte').prettier,
      },
      vue = {
        require('formatter.filetypes.vue').prettier,
      },
      php = {
        require('formatter.filetypes.php').php_cs_fixer,
      },
      go = {
        require('formatter.filetypes.go').gofmt,
      },
      rust = {
        require('formatter.filetypes.rust').rustfmt,
      },
      nix = {
        require('formatter.filetypes.nix').nixfmt,
      },
    }

    -- sed on windows works differently and this formatter throws an error
    if not require('helpers.utils').is_win() then
      formatters['*'] = {
        require('formatter.filetypes.any').remove_trailing_whitespace,
      }
    end

    return formatters
  end,
}
