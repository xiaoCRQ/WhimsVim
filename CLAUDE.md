# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

LazyVim-based Neovim configuration, customized for competitive programming (C/C++). Uses **lazy.nvim** as the plugin manager with the LazyVim distribution as a base, plus custom overrides.

## Boot sequence

1. `init.lua` — entry point, loads in this order:
   - `config.lazy` — plugin manager bootstrap + plugin specs + LazyVim extras
   - `config.neovide` — Neovide GUI settings (fonts, cursor effects, transparency)
   - `config.function` — utility functions (`font()`, `Complete_semicolon()`)

2. `config.lazy.lua` — bootstraps lazy.nvim, then declares plugin specs:
   - Imports all of LazyVim core plugins (`lazyvim.plugins`)
   - Imports custom plugins from `plugins/` directory
   - Imports LazyVim extras: `luasnip`, `dap.core`, `dap.nlua`, `lang.markdown`

3. `config.options.lua` — Neovim options automatically loaded before lazy.nvim startup

4. `config.keymaps.lua` — custom keymaps loaded on `VeryLazy` event

## Directory structure

```
init.lua              — entry point
lazy-lock.json         — plugin version lockfile
lazyvim.json           — LazyVim extras declaration (clangd, cmake, json, python)
stylua.toml            — Lua formatter config (2-space indent, 120-char width)
lua/
├── config/
│   ├── lazy.lua       — plugin manager + specs (+ LazyVim extras)
│   ├── options.lua    — vim.opt settings
│   ├── keymaps.lua    — all custom keymaps
│   ├── function.lua   — utility functions (font resize, C/C++ semicolon insert)
│   └── neovide.lua    — Neovide GUI config
├── plugins/
│   ├── blink.cmp.lua     — completion engine (blink.cmp + dictionary + LSP)
│   ├── snacks.nvim.lua   — dashboard with LeetCode/config shortcuts + chafa image
│   ├── nvim-dap.lua      — debug adapter (loads .vscode/launch.json for codelldb)
│   ├── leetcode-nvim.lua — LeetCode integration with `<leader>l*` keymaps + CN endpoint
│   └── faster-oj.nvim.lua — competitive programming tool (CodeForces, local dev)
├── logo/              — GIF images for dashboard display (rendered via chafa)
└── resource/          — words_alpha.txt dictionary for blink-cmp-dictionary
```

## Key plugins and their roles

- **blink.cmp** (saghen/blink.cmp) — completion engine replacing nvim-cmp. Sources: dictionary, lsp, path, buffer. Uses `<Tab>`/`<S-Tab>` for navigation, `<C-y>` to accept.
- **snacks.nvim** (folke/snacks.nvim) — dashboard with chafa-rendered GIF and quick actions (Find File, LeetCode, Config, Quit).
- **nvim-dap** (mfussenegger/nvim-dap) — debug adapter. Custom `<leader>dL` loads `.vscode/launch.json` with codelldb for C/C++/Rust.
- **leetcode.nvim** (kawre/leetcode.nvim) — LeetCode integration with CN endpoint enabled, `<leader>l*` prefix keymaps.
- **faster-oj.nvim** (xiaocrq/faster-oj.nvim) — competitive programming tool for CodeForces. Local development from `~/Work/Program/CodeForces`. Keymaps under `<leader>cd*`.

## Notable custom keymaps

In normal mode, single-letter command sequences (no leader prefix):
- `q` = buffer delete, `qq` = force quit, `w` = force write, `wq` = force write+quit
- `N` = 5j, `M` = 5k (vertical movement)
- `;;` mapped to `:` (easier command entry)
- Alt+hjkl = window navigation; `S-W`/`S-S` = vertical/horizontal split

In insert mode, double-digit sequences expand to shifted symbols (e.g., `11` → `!`, `99` → `()`). Bracket pairs auto-close with cursor placement.

## LSP and language support

LazyVim extras enabled: clangd, cmake, json, python (declared in `lazyvim.json`). Markdown extra is imported in `lazy.lua`. The config is C/C++ oriented — `Complete_semicolon()` in `function.lua` auto-appends `;` when pressing `;` in C/C++ files.

## Code formatting

Use `stylua` for Lua formatting: `stylua lua/`. Config in `stylua.toml`: 2 spaces, 120-char column width.

## Configuring plugins

To change a plugin's options, edit or create a file in `lua/plugins/` that returns a lazy.nvim spec table. The custom `plugins/` directory takes precedence over LazyVim defaults. Plugin specs defined in `config/lazy.lua` (the `spec` table) also work for quick additions.
