local root_config = require('helpers.root-config')

local function project_root(ctx)
  return root_config.project_root({ bufnr = ctx.buf })
end

local function uses_direnv(ctx)
  return vim.uv.fs_stat(project_root(ctx) .. '/.envrc') ~= nil
end

return {
  command = function(_, ctx)
    return uses_direnv(ctx) and 'direnv' or 'pnpm'
  end,
  args = function(_, ctx)
    local args = { 'exec', 'vp', 'fmt', '--stdin-filepath', ctx.filename }
    if uses_direnv(ctx) then
      return vim.list_extend({ 'exec', project_root(ctx), 'pnpm' }, args)
    end
    return args
  end,
  stdin = true,
  cwd = function(_, ctx)
    return project_root(ctx)
  end,
}
