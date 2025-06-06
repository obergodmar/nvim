---@type LazySpec
local P = {
  -- Secure load local config files.
  'klen/nvim-config-local',
  opts = {
    config_files = { '.nvim.lua' },
    -- Where the plugin keeps files data
    hashfile = vim.fn.stdpath('data') .. '/config-local',
    autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
    commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
    silent = false, -- Disable plugin messages (Config loaded/ignored)
    lookup_parents = false,
  },
}

return P
