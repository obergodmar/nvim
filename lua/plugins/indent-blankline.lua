return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("indent_blankline").setup({
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true,
    })

    vim.opt.list = true
    vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
    vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]])
    vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")
    vim.opt.listchars:append("trail:~")
    vim.opt.listchars:append("nbsp:⍽")

    vim.opt.foldmethod = "indent"
    vim.opt.foldnestmax = 10
    vim.opt.foldenable = false
    vim.opt.foldlevel = 2
    vim.opt.cursorline = true
  end,
}
