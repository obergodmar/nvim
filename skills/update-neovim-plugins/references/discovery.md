# Native lazy.nvim discovery

Sources: [lazy.nvim usage/API](https://lazy.folke.io/usage) and
[configuration](https://lazy.folke.io/configuration). Verify the installed trusted
revision's implementation before using internal target/error fields; these are
not stable public APIs.

## Isolated discovery

Generate a minimal temporary Lua initializer from the inspected configuration.
Use only declarative repository/name/path selectors and mark every plugin lazy.
Do not import `lua/plugins`, copy `init`/`config`/`opts` functions, or load
plugin-supplied specs. Include enabled dependencies explicitly, preserving
`branch`, `tag`, `version`, `commit`, `pin`, and `submodules` constraints.
Local/dev plugins need separate review and must not be treated as remotes.

Run with `nvim --headless -u /tmp/<run>/discover.lua -i NONE`, temporary XDG
data/state/cache/config roots, and a scratch working directory. Use independent
Git clones in a temporary plugin root, initialized at recorded baseline revisions.
Avoid symlinks or shared refs with live checkouts: fetch can rewrite refs/tags
without checking out code. Provide a copy of the trusted manager checkout;
clone/fetch alone does not authorize running it.

Restrict `runtimepath` to Neovim's `$VIMRUNTIME` and the trusted manager, clear
`packpath`, and pass these options to the manager's `setup`, adapting them to
the verified version's API:

```lua
{
  root = temporary_plugin_root,
  lockfile = temporary_baseline_lockfile,
  defaults = { lazy = true },
  local_spec = false,
  install = { missing = false },
  checker = { enabled = false },
  change_detection = { enabled = false },
  pkg = { enabled = false },
  rocks = { enabled = false },
  performance = { rtp = { reset = false } },
}
```

Do not add `--noplugin` blindly: some lazy.nvim revisions return from `setup`
when `vim.go.loadplugins` is false. Minimal specs, restricted runtime paths,
and disabled package discovery prevent candidate plugin execution here;
headless mode alone does not.

Call `require('lazy').check({ wait = true, show = false, plugins = names })`.
Export JSON containing every name, URL, directory, baseline SHA, candidate full
SHA, branch/tag/version, and errors. In the currently inspected implementation,
`require('lazy.manage.git').get_target(plugin)` resolves the configured target
after fetching; `plugin._.updates` alone misses unchanged/pinned entries.
For `pin = true`, explicitly retain the baseline SHA even if `get_target` resolves
a newer branch commit. Inspect tasks with `task:has_errors()` and `task:get_log()`;
terminate with `:cquit` on errors. Missing commits are failures, not "no update".
Quit only after all tasks and manifest writes finish.

Compare checkout HEADs and contents before/after discovery: they must remain
at baseline. Do not write candidates into the repository lockfile yet. The
manager may insert itself into the resolved spec; account for its trusted copy
explicitly even when it is absent from the original lockfile.

## Frozen application

After review and fork publication, create a candidate lockfile with accepted
exact SHAs and old SHAs for retained plugins. Use the reviewed full configuration
for builds/runtime checks, restoring build hooks and package handling only after
reviewing them. Explicitly select temporary lockfile and plugin paths. Call
`require('lazy').restore({ wait = true, show = false, plugins = accepted_names })`
for existing plugins. For missing plugins, verify that the trusted version supports
`install({ wait = true, show = false, lockfile = true, plugins = names })`.
Inspect task errors and every actual HEAD after either operation.

Apply to live paths using a minimal maintenance initializer to prevent startup
loading mixed old/new revisions before migrations and builds finish. Carry
reviewed build hooks explicitly; inspect the manager's behavior for hooks needing
runtime loading (such as `:TSUpdate`). Do not claim `restore` is execution-free.
Only start the migrated full config once live HEADs match the manifest.

Resolve all placeholder paths/variables for the target host before running any
commands. Enforce the same manifest through staging, live installation, lockfile
writing, and final verification. Check the trusted version's lock writer: it may
rewrite entries outside the requested plugin subset. Preserve retained/disabled
entries and verify the entire final lockfile, not only updated names.
