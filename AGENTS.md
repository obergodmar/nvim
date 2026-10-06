# Neovim Configuration

## Scope and layout

This repository configures Neovim with lazy.nvim. Keep agent instructions,
local skills, documentation, and commit messages in English. Match the user's
language for conversation.

- `init.lua`: lazy.nvim bootstrap and setup.
- `lua/plugins/`: plugin specifications and configuration.
- `lua/helpers/`: shared helpers, including CoC and native LSP configurations.
- `after/plugin/`: editor defaults, commands, mappings, and autocommands.
- `lazy-lock.json`: exact plugin revisions. The filename is not `lazy.lock`.
- `stylua.toml`, `.luacheckrc`, `.editorconfig`: formatting and lint settings.

lazy.nvim itself is bootstrapped under `stdpath('data')/lazy/lazy.nvim`;
configured plugins live under `stdpath('data')/plugins`. Resolve actual paths
and active specifications rather than assuming lazy.nvim's default root.
Some plugins are disabled or conditional; preserve those choices.

## Plugin maintenance routing

For requests such as "update plugins", "time to update plugins", or
"пора обновить плагины", read and follow
[the local update-neovim-plugins skill](skills/update-neovim-plugins/SKILL.md).
This explicit routing also applies if the session's skill catalog does not
automatically discover repository-local skills.

An update request authorizes the workflow's candidate review, applicable
configuration migrations, validation, and upstream rebases and publication
of confirmed user-owned forks. Creating these instructions alone does not
request an update. Respect runtime filesystem, network, and approval limits.

Keep configuration and lockfile changes uncommitted and unstaged for review.
Commit only when subsequently requested. Fork rebase commits and authorized
fork pushes are a separate part of plugin maintenance, not a commit or push
of this configuration repository.

## Editing and validation

Preserve unrelated changes. Use two spaces and the existing Lua style; run
StyLua with `stylua.toml` and LuaCheck with `.luacheckrc` when changing Lua.
Do not suppress new diagnostics just to pass a check. Report unavailable tools.
Use focused startup, health, and behavior checks for plugin changes as specified
by the maintenance skill. Do not equate a successful headless exit with fully
working plugins.

For a later commit, inspect applicable parent instructions and local hooks,
review the intended diff, and run required checks. Use an English Conventional
Commit, normally `chore(deps): update Neovim plugins`; include a concise body
for relevant migrations and fork rebases. Do not push this repository unless
requested.
