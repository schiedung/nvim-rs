# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal Vim/Neovim dotfiles. There is no build, no test suite, and no linter — the
"product" is three editor configs plus shell/batch scripts that install them into the
user's home directory. README.md holds the plugin tables and the full keybinding
reference; do not duplicate them here or in other docs.

## Two configs, two editors

There is one Neovim config and one legacy Vim config, installed by different scripts:

| File | Editor | Plugin manager | Installed by | Target |
| --- | --- | --- | --- | --- |
| `nvim/init.lua` | Neovim | lazy.nvim (`stdpath("data")/lazy`) | `setup-nvim.sh` / `setup-nvim.bat` | `~/.config/nvim/init.lua` |
| `vim/vimrc` | Vim | Vundle (`~/.vim/bundle`) | `install.sh` | `~/.vimrc` |

`nvim/init.vim` (a third, Vundle-based Neovim config) was deleted — it is unsupported.
Do not reintroduce it: two Neovim configs cannot coexist, since Neovim loads `init.lua`
and raises `E5422: Conflicting configs` when both are present.

Consequences worth knowing before editing:

- **`vimrc` is legacy and nothing mirrors it any more.** It used to be a near-duplicate
  of `init.vim`, so fixes were applied in both. With `init.vim` gone, `vimrc` carries the
  older drift alone: it still uses fugitive commands that current fugitive has removed
  (`:Gstatus`, `:Gdiff`, `:Gcommit`), duplicates `hardtime_default_on`, and maps `<F3>`
  to YouCompleteMe, a plugin no longer in its own plugin list. Neovim changes do **not**
  need porting to it.
- **On Linux the configs are symlinked, so repo edits are live** — no reinstall needed,
  just restart the editor. The Windows `.bat` scripts `COPY` instead, so Windows users
  must re-run `setup-nvim.bat` after every change.
- **`install.sh` no longer installs a Neovim config.** It installs `vimrc` + Vundle for
  Vim, and separately the Neovim ancillaries: the `nvim/svndiff.sh` and
  `nvim/svnmerger.sh` SVN wrappers (which invoke `nvim -d`), the Nerd Font, and
  `git core.editor`. `setup-nvim.sh` installs `init.lua` and nothing else, so a
  Neovim-only setup does not get the SVN wrappers or the font.
- There is no `install.bat`; the only Windows scripts are `setup-nvim.bat`,
  `purge-nvim.bat`, and `purge.bat`. README used to point at `./install.bat` and no
  longer does — don't re-add that reference.

## Installing and verifying changes

The install/purge scripts mutate the real user environment; they are not sandboxed and
not safely reversible. `install.sh` sets `git config --global core.editor`, clones Vundle
into `~/.vim`, and downloads a Nerd Font into `~/.local/share/fonts`. `purge.sh` removes
`~/.vimrc`, `~/.vim`, `~/.config/nvim`, `~/.local/share/nvim` (every installed plugin),
`~/.local/state/nvim` and `~/.cache/nvim`. Never run these to "test" a change without
explicit confirmation.

```bash
./setup-nvim.sh     # init.lua (lazy.nvim); plugins install on first launch
./install.sh        # vimrc + Vundle for Vim, SVN wrappers, font, git core.editor
./purge-nvim.sh     # removes Neovim config AND plugin data  (prompts y/n)
./purge.sh          # also removes ~/.vim and ~/.vimrc       (prompts y/n)
```

**To exercise an installer safely, point `HOME` at a throwaway directory** — the scripts
respect it, including `git config --global`:

```bash
HOME=$(mktemp -d) bash ./setup-nvim.sh   # then inspect that tree
```

Verification is otherwise manual — there is no test suite:

```bash
# Startup must be silent
nvim --headless -c 'sleep 8' -c 'messages' -c 'qa!'

# LSP: expect 9 buffer-local normal maps (8 from on_attach + built-in K)
nvim --headless some.cpp -c 'sleep 8' \
  -c 'lua print(#vim.api.nvim_buf_get_keymap(0,"n"))' -c 'qa!'

# A lazy-loaded plugin's commands must exist at startup. Check exists() BEFORE
# require()-ing anything: require("gp") loads the plugin and masks the bug.
nvim --headless -c 'sleep 8' -c 'lua print(vim.fn.exists(":GpChatNew"))' -c 'qa!'

bash -n install.sh setup-nvim.sh purge.sh purge-nvim.sh
```

Note `--headless` never fires `UIEnter`, so `event = "VeryLazy"` plugins do not load in
these checks; use a `cmd`/`keys` trigger if you need the command to be verifiable.

Then inside Neovim: `:checkhealth`, `:Lazy` (plugin state), `:Mason` (language servers).

Editing `install.sh`: the font branch does `cd ~/.local/share/fonts && curl ...` and
never returns. It is harmless today only because every `${PWD}`-based symlink happens
earlier in the script. Any code appended to that branch will resolve `${PWD}` to the
font directory.

## init.lua structure and known gaps

Single file, ordered: lazy.nvim bootstrap → `vim.opt` globals and a few keymaps → an
`on_attach` helper → filetype autocmds (`*.frag`/`*.vert` → glsl, `*.sage` → python) →
one `require("lazy").setup{}` call containing every plugin spec inline. Each plugin's
config lives in its own `config = function()` inside that spec, including its keymaps —
so a keybinding change means finding the owning plugin entry, not a central keymap
table.

- **LSP wiring uses the nvim 0.11+ API, not lspconfig's old `setup()` framework.**
  `nvim-lspconfig` here serves only as a provider of `lsp/<server>.lua` definitions; its
  `config` calls `vim.lsp.enable({ "clangd", "lua_ls" })`. Keybindings are applied by an
  `LspAttach` autocmd that calls the shared `on_attach`. Do **not** reintroduce
  `require("lspconfig")[server].setup{}` — that framework is gone in current lspconfig.
  Observed on nvim 0.13.0-dev while writing this: registering the callback via
  `vim.lsp.config('*', { on_attach = ... })` left the mappings unset even though the
  callback was visible on `client.config` — the mechanism was not tracked down, so treat
  it as an observation rather than a settled API limitation. `LspAttach` works reliably;
  prefer it. `clangd` comes from `/usr/bin`,
  `lua_ls` from mason — hence `nvim-lspconfig` depends on `mason.nvim` so mason's bin
  directory is on `PATH` before a server is resolved.
- **Do not re-add LSP mappings that Neovim 0.11+ already ships.** `on_attach` deliberately
  omits `gr`, `K`, `grn`-equivalents and code-action: the defaults (`grr`, `grn`, `gra`,
  `gri`, `grt`, `K`) cover them. Mapping bare `gr` is the specific trap — it is a complete
  match sitting on the `gr*` prefix, so every `gr` press waits out `timeoutlen`. The
  built-ins still fire correctly either way; the cost is latency, not breakage.
- **Every lazy-loaded plugin needs a trigger.** `lazy = true` with no `event`/`cmd`/
  `keys`/`ft` means the plugin never loads at all — that silently disabled `gp.nvim` and
  `indent-blankline` for a long time. Conversely, do not lazy-load `vim-fugitive` on its
  five mapped keys: it provides many more commands, and gating it hides them.
- **`nvim-treesitter` is pinned to `branch = "master"`** because the config uses the
  classic `require'nvim-treesitter.configs'` API. That branch is frozen upstream and
  declares Neovim 0.12+ unsupported, so migrating to the `main` API is pending work — but
  removing the pin without migrating will break a fresh clone once `main` becomes default.
- **Update checking, not auto-updating**: `checker = { enabled = true }` only surfaces
  notifications; updates are applied solely by `:Lazy update`. (`auto_install` used to sit
  in this table and was silently ignored — it is not a valid `checker` key.)
  `lazy-lock.json` lives in `~/.config/nvim/`, not in this repo, so plugin versions are
  not pinned in version control.
- **Check `exists()` before mapping a plugin command.** Fugitive removed `:Gstatus` and
  `:Gcommit`; `:Gdiff`/`:Gvdiff` survive only as abbreviations of `:G[v]diffsplit`, which
  is why the mappings now spell commands in full. `vim.fn.exists(":Cmd")` returns 2 for an
  exact command, 1 for an abbreviation, 0 for nothing.
- `gp.nvim` reads `OPENAI_API_KEY` from the environment and points its ollama provider at
  `http://localhost:11434`.
- `_G.vim = vim` on line 1 is deliberate — it keeps `vim` visible to the LSP/lua_ls.

## Conventions

`.editorconfig` governs: 4-space indent, trailing whitespace trimmed (except in
Markdown, where it is significant for line breaks). Keep lines under 80 columns where
practical — all three configs set `colorcolumn=80`.

Per CONTRIBUTING.md, a plugin change should also update the plugin table in README.md
and add an entry to CHANGELOG.md. `init.lua` plugin specs lazy-load via `keys`, `cmd`,
`event` or `ft` where the plugin is not needed at startup; follow that when adding one,
and give every mapping a `desc` so which-key can label it.

**Requires Neovim 0.11+** (`vim.lsp.enable`, `vim.diagnostic.jump`). README, CONTRIBUTING
and CHANGELOG all state this; keep them in sync if the floor moves again.
