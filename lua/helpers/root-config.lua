local M = {}

local default_project_root_markers = { '.git' }

local function normalize(path)
  return path and vim.fs.normalize(path) or nil
end

local function is_parent(parent, child)
  parent = normalize(parent)
  child = normalize(child)

  if not parent or not child then
    return false
  end

  return child == parent or vim.startswith(child, parent .. '/')
end

local function path_from_opts(opts)
  if opts.path then
    return opts.path
  end

  local bufnr = opts.bufnr or 0
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname ~= '' then
    return bufname
  end

  return vim.uv.cwd()
end

local function dirname_from_opts(opts)
  local path = path_from_opts(opts)
  if opts.is_dir then
    return path
  end

  return vim.fs.dirname(path)
end

function M.project_root(opts)
  opts = opts or {}

  local dir = dirname_from_opts(opts)
  if not dir or dir == '' then
    return vim.uv.cwd()
  end

  local root = vim.fs.root(dir, opts.project_root_markers or default_project_root_markers)
  if root then
    return root
  end

  local cwd = vim.uv.cwd()
  if is_parent(cwd, dir) then
    return cwd
  end

  return dir
end

function M.find_nearest(files, opts)
  opts = opts or {}

  local dir = dirname_from_opts(opts)
  if not dir or dir == '' then
    return nil
  end

  local root = opts.project_root
    or M.project_root({
      path = dir,
      is_dir = true,
      project_root_markers = opts.project_root_markers,
    })
  -- vim.fs.find excludes the stop directory, so stop at the parent to include the root.
  local stop = root and vim.fs.dirname(root) or nil

  return vim.fs.find(files, {
    upward = true,
    path = dir,
    stop = stop,
    limit = 1,
  })[1]
end

function M.exists(files, opts)
  return M.find_nearest(files, opts) ~= nil
end

return M
