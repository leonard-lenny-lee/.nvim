# Neovim configuration

Personal configuration based on kickstart.nvim, using **Neovim 0.11.x** and **lazy.nvim**. Catppuccin is the default theme.

The current setup has been tested on 0.11.1, but the installed nvim-lspconfig declares a **0.11.3 minimum**. A patch update within 0.11 is recommended before updating plugins. Moving to 0.12 is optional.

## Layout

| Path | Purpose |
| --- | --- |
| `init.lua` | Loads settings before plugins |
| `lua/config/` | Options, keymaps, autocommands, plugin manager, health check |
| `lua/plugins/` | Editor/UI, Telescope, Git, LSP, completion, formatting, Treesitter |
| `lua/optional/` | Disabled debugging, linting, and Neo-tree configurations |
| `lazy-lock.json` | Plugin revisions for reproducible restores |

Only `lua/plugins/` is automatically imported. To enable an optional configuration, add an explicit `require 'optional.<name>'` entry to the specs in `lua/config/lazy.lua` and check its external tool requirements.

## Editing

- **Navigation:** Space is the leader. Telescope provides search and LSP pickers; Ctrl-H/J/K/L move between windows.
- **Completion:** Blink uses Enter to accept and Tab/Shift-Tab for selection and snippet navigation, with LuaSnip and the Lua fuzzy matcher.
- **Languages:** Mason installs and enables Pyright, Lua Language Server, and Texlab. Rust and C/C++ servers are excluded from automatic installation and activation. Other manually installed Mason language servers can activate automatically.
- **TeX:** `.tex` files use the `tex` filetype, British spelling, four-space indentation, and expanded tabs. Markdown also uses British spelling.
- **Formatting:** Conform uses StyLua for Lua and LSP fallback elsewhere. Save formatting has a 500 ms timeout and is disabled for C/C++. `<leader>f` formats manually. StyLua is excluded from LSP activation because the installed binary does not support `--lsp`.
- **Git:** Gitsigns provides signs and `<leader>h` hunk actions; Diffview is also available. `<leader>hu` toggles hunk staging and `<leader>tD` previews deleted lines inline.

LSP configuration uses Neovim's native `vim.lsp.config()` API; Mason's automatic enablement calls `vim.lsp.enable()`. Server settings live in `lua/plugins/lsp.lua`.

## Maintenance

Keep `lazy-lock.json` in version control. Use `:Lazy restore` to restore its plugin revisions. Review compatibility before updating plugins while staying on 0.11. The lockfile does **not** pin Mason packages or compiled Treesitter parsers.

Treesitter deliberately uses the frozen **master** branch for Neovim 0.11. Keep that branch and its `nvim-treesitter.configs` setup together.

Check configuration health with `:checkhealth config`. For broader checks, load the lazy-loaded formatter first:

```vim
:lua require('lazy').load { plugins = { 'conform.nvim' } }
:checkhealth config vim.deprecated vim.lsp nvim-treesitter conform lazy mason
```

Format and check Lua files with StyLua (installed through Mason):

```sh
stylua --check init.lua lua
git diff --check
```

If StyLua is not on your shell's PATH, use `~/.local/share/nvim/mason/bin/stylua`.

Known health warnings include the 0.11.1 version gap, an internal `vim.validate` deprecation in the locked Gitsigns revision, and missing optional toolchains reported by Mason/Lazy. No active plugin requires LuaRocks. Install additional toolchains only when needed.

## If upgrading later

Lazy.nvim and the native LSP setup can stay. Neovim 0.12 requires a deliberate migration to Treesitter's rewritten `main` API: replace the old setup options, configure parser installation and highlighting/indentation, and update parsers. Also review mini.ai's `an`/`in` mappings for conflicts with built-in incremental selection. Consult the then-current [Treesitter instructions](https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md) and [nvim-lspconfig requirements](https://github.com/neovim/nvim-lspconfig#readme) before upgrading.
