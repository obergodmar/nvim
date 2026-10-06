---
name: update-neovim-plugins
description: Update this repository's lazy.nvim plugins, review exact revisions and upstream changes, rebase and publish confirmed user-owned forks, migrate affected configuration, and validate Neovim. Use for plugin maintenance requests in any language.
---

# Update Neovim plugins

Complete the update and leave this configuration repository's changes uncommitted
and unstaged. Reading this skill while creating instructions does not request an
update. Respect execution permissions even when the workflow authorizes an action.

## 1. Capture the baseline

- Read `AGENTS.md`, inspect status and relevant diffs, and preserve user work.
  Save the current on-disk `lazy-lock.json`, affected config files, installed full
  SHAs, remote URLs, branch refs, and plugin checkout status in a temporary run
  directory. Use the on-disk lockfile, not `git show HEAD`, as the baseline.
- Inspect `init.lua`, all plugin specs and helpers, and runtime versions. Resolve
  names, dependencies, URLs, selectors (`branch`, `tag`, `version`, `commit`,
  `pin`), conditions, build hooks, local/dev plugins, and the CoC/native LSP mode.
  Account for every lock entry and active dependency absent from the lockfile.
  Do not enable disabled plugins or change conditional paths to update them.
- Discover actual manager/plugin paths. Before executing the existing config,
  compare installed HEADs with the baseline and inspect dirty checkouts. Never
  reset, stash, delete, or overwrite user edits automatically. Use isolated
  checkouts if installed versions differ from the trusted baseline.
- Include lazy.nvim itself in the review. It may be absent from the lockfile:
  record its installed revision explicitly. Do not bootstrap or execute an
  unreviewed manager revision.

## 2. Discover without executing candidates

Use the trusted lazy.nvim version's native
`require('lazy').check({ wait = true, show = false, plugins = names })` API.
This fetches updates; `update` and `sync` are not discovery operations.
Read [the discovery procedure](references/discovery.md) before invoking Neovim.

Keep candidate objects and full SHAs in a separate manifest in the run directory.
Respect configured selectors; do not replace release constraints with branch
HEADs or silently unpin plugins. Audit disabled lock entries at their retained
SHAs and label them retained, rather than updated or runtime-tested. Fetch
missing candidates into temporary Git repositories without loading or building
them; review these before a native install operation.

## 3. Review each exact revision

For every retained or proposed plugin revision, verify repository identity and
SHA and check current primary sources: security advisories, release notes,
issues, relevant PRs, and maintainer notices. Search for regressions, compromise
reports, and problems affecting this configuration and Neovim version. Record
the date, links, inspected range, CI results where available, and decision.
Unavailable/private sources mean incomplete evidence, not a clean bill of health.

For each changed plugin, inspect the entire `old_sha..candidate_sha` history and
net diff, including merge changes. If history was rewritten, examine both sides
from the merge base; an empty forward range does not imply unchanged code.
Review executable Lua/Vimscript, shell/process/network calls, build hooks,
dependency/lockfile changes, binary downloads, package metadata, submodules,
and credential or telemetry behavior. Investigate unexpected ownership, remote,
tag, provenance, or generated artifact changes. Signatures and green CI provide
supporting evidence, not proof of safety.

Read API/migration docs at the candidate SHA and map changes to this config and
its mappings. Apply necessary migrations while preserving behavior. Report
useful new features with links; do not enable optional features without a request.
Do not automatically raise the required Neovim version or change the user's LSP
mode to make an incompatible update pass.

Retain the previous revision for suspect, incompatible, or insufficiently
reviewed candidates. If the old revision is itself suspected compromised, stop
executing that plugin and report the finding before further runtime checks.
Continue independent safe updates and report partial completion explicitly.
Never claim that all bugs or malicious code have been ruled out.

## 4. Rebase confirmed user-owned forks

Inspect all `obergodmar/*` specs, including themes and helper-defined dependencies.
Ownership alone does not make a repository a fork: use hosting metadata (`parent`
and `source`), remotes, README/history, and ancestry to identify the correct
upstream and branch. Treat original user projects as ordinary plugins. If upstream
or the intended branch is unclear, retain that plugin and ask for the missing fact.

For a confirmed fork:

1. Reuse a clean local clone or create an isolated clone. Do not rebase an
   installed detached checkout. Inspect applicable fork instructions and hooks.
   Verify `origin` belongs to the user; add a verified `upstream` remote if absent.
   Do not overwrite a conflicting existing remote automatically.
2. Fetch origin and upstream. Record the full remote branch SHA and keep a local
   backup ref. Select the appropriate upstream branch, respecting special fork
   branches such as `extra-setup-tmTheme`. Establish the fork base and inspect
   all fork-only changes, including commits after the baseline pin.
3. Review incoming upstream commits using the same checks as ordinary plugins.
   Rebase fork-only changes onto the reviewed, recorded upstream SHA, not a moving
   branch name. Preserve custom behavior; compare with `git range-diff` and inspect
   the resulting diff. Review merge topology before choosing rebase options;
   do not silently discard merges or custom patches.
4. Resolve understood conflicts and run relevant fork tests/build and applicable
   integration checks in isolation. Abort the isolated rebase when preserving
   intent is uncertain. Never publish an unvalidated result.
5. Push only the verified fork branch with an explicit refspec. Use a normal push
   if possible; when rebase requires rewriting published history, use
   `--force-with-lease=refs/heads/<branch>:<recorded_remote_sha>`. This scoped
   rewrite is authorized by the repository's update workflow. Never use plain
   `--force`, push all branches/tags, bypass hooks, or push to upstream.
   On lease rejection, fetch and review concurrent work; do not blindly refresh
   the lease and retry. If reconciliation requires a scope decision, stop that
   fork and report it while continuing independent plugins.
6. Verify the remote branch reaches the resulting full SHA. Review that SHA as
   the fork candidate, fetch it through lazy's check API again, and record both
   upstream and new fork SHAs. If pushing is blocked, retain the old configuration
   pin and report the prepared local result.

## 5. Apply reviewed SHAs

Prepare migrations before executing new versions. Freeze accepted SHAs in a
temporary spec/lockfile and use native lazy operations to install/restore those
exact revisions. `restore` still fetches and executes build hooks: review hooks
and their transitive package downloads before this step. Never run unrestricted
`Lazy sync` or floating `update` after review; upstream can move in the meantime.

Stage builds and runtime checks in isolated data/state/cache/config directories.
Include plugin-provided package specs and new dependencies in the review; do not
let package discovery install unchecked code. Preserve real build behavior.
In particular, review the CoC hook `npm ci & npm run build`: shell `&` backgrounds
installation and can race the build; serialize it when repairing that active hook.

Promote tested revisions through the trusted manager with exact pins and an
explicit repository lockfile path. Preserve original selector semantics in the
final configuration; temporary pins must not become permanent accidentally.
Verify every resulting lock SHA and installed HEAD against the manifest, including
dependencies and the manager. Retain rejected and disabled entries. Inspect lazy
task errors and logs even if the process exits zero.

## 6. Validate and recover

- Run formatting/lint checks for changed Lua and `git diff --check`.
- Use this repository's config explicitly (including `lua` and `after` runtime
  paths), not an unrelated `~/.config/nvim`. Capture headless startup messages/logs;
  exercise events, filetypes, commands, and key-triggered loads, including the
  conditional paths applicable on this host.
- Run `:checkhealth`, save its buffer to the run report, and inspect errors and
  warnings. Compare with a baseline captured under the same environment. Health
  checks may load code; run them only after reviewing the revisions they execute.
- Smoke-test theme/UI, file browsing, search, Git integrations, yank/select
  actions, terminal, sessions, formatting, Treesitter parsers/textobjects/folding,
  and the active completion/LSP mode. Include Markdown preview and applicable
  external tools/build outputs. Use scratch files and temporary Git repos. Avoid
  overwriting real sessions, project files, or clipboard contents, and do not
  trust project-local config during tests.
- Check interactively when behavior depends on UI. Label unavailable manual
  checks, credentials, external servers, previews, and binaries as not tested.
  Health plus startup does not prove every plugin works.

Fix update-induced errors within scope and repeat affected checks. Otherwise
restore affected previous pins, config changes, and installed revisions through
reviewed native restore operations, preserving unrelated work. Rerun relevant
checks after rollback. A published fork cannot be undone by restoring a local
lockfile: report that distinction and never rewrite it back automatically.

## 7. Deliver the summary

Report updated, retained, rejected, and untested plugins separately. Include:

- Plugin/repository, old/new SHAs, branch/version, and comparison links.
- Security/stability evidence and remaining uncertainty per reviewed plugin.
- Breaking changes, applied migrations, fixes, and useful new features with links.
- Fork upstream/branch, rebased custom changes, new remote SHA, and push outcome.
- Checks run, results, baseline warnings, rollbacks, and limitations.
- Changed config files and confirmation that they remain uncommitted.

Keep the chat summary concise; put detailed per-plugin evidence and validation
results in an English run report under `/tmp` and link it. Save it in the repository
only if requested. On a later commit request, follow `AGENTS.md` and applicable
parent commit instructions; use `chore(deps): update Neovim plugins` with relevant
migrations and fork updates in the body.
