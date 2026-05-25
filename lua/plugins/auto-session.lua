return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
    { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
  },

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_restore_last_session = true,
    single_session_mode = true,
    args_allow_single_directory = false,
    bypass_save_filetypes = { 'oil' },
    pre_save_cmds = {
      function()
        -- list current buffers
        local buffers = vim.api.nvim_list_bufs()

        local toggleterm_exists = false
        for _, buf in ipairs(buffers) do
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:find('toggleterm#') then
            toggleterm_exists = true
            break
          end
        end

        if toggleterm_exists then
          vim.cmd([[ ToggleTermToggleAll ]])
        end
      end,
    },
    cwd_change_handling = false,
    -- log_level = 'debug',
  },
}
