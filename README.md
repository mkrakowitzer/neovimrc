# neovimrc files

Heavily based off the primeagens neovimrc with my own customisations.

## requirements

Easiest way to install all the requirements is to install my [dotfiles](https://github.com/mkrakowitzer/dotfiles)
and run the setup script otherwise good luck.

## Install

```bash
git clone https://github.com/mkrakowitzer/neovimrc
cd neovimrc
./deploy.sh
```

## Plugins

The configuration includes the following plugins for various enhancements:

| Plugin Name | Description |
| ----------- | ----------- |
| `cloak.nvim` | Masks specified patterns in files with overlay characters. |
| `fugitive` | A comprehensive Git integration plugin for Neovim. |
| `neogen` | Facilitates easy generation of annotations and documentation. |
| `Telescope` | Offers fuzzy file searching capabilities within Neovim. |
| `harpoon` | Provides quick navigation to marked files. |
| `undo` | Enhances Neovim's undo functionality with persistent undo files. |
| `neotest` | Integrates a test runner within Neovim. |
| `LuaSnip` | Manages snippets for faster coding. |

## Keymaps

### Telescope

| Mode | Key Mapping | Description |
| ---- |------------ | ----------- |
| `n` | `<leader>pv` | Opens the file tree. |
| `n` | `<leader>pf` | Initiates a file search. |
| `n` | `<C-p>` | Searches for files within Git projects. |
| `n` | `<leader>ps` | Performs a grep search in files. |

### Harpoon

| Mode | Key Mapping | Description |
| ---- |------------ | ----------- |
| `n` | `<leader>a` | Appends the current file to the Harpoon list for quick navigation. |
| `n` | `<C-e>` | Toggles the Harpoon quick menu. |
| `n` | `<C-h>` | Navigates to the previous file in the Harpoon list. |
| `n` | `<C-l>` | Navigates to the next file in the Harpoon list. |

### Undo

| Mode | Key Mapping | Description |
| ---- |------------ | ----------- |
| `n` | `<leader>u` | Performs an undo operation. |
| `n` | `ctrl-w` | Switches between panes. |

### Fugitive

| Mode | Key Mapping | Description |
| ---- |------------ | ----------- |
| `n` | `<leader>gs` | Opens the Fugitive Git status window. |
| `n` | `<leader>p` | Pushes the current branch to its upstream. |
| `n` | `<leader>P` | Pulls the current branch with rebase. |
| `n` | `<leader>t` | Pushes the current branch with set-upstream. |
| `n` | `gu` | Performs a `diffget //2` in a Git diff window. |
| `n` | `gh` | Performs a `diffget //3` in a Git diff window. |

### General

| Mode | Key Mapping | Description |
| ---- |------------ | ----------- |
| `n`  | `V%= format block` | Format the selected block. |
| `n`  | `<leader>pv`       | Opens the command-line window with Ex command. |
| `v`  | `J`                | Move selected block of text down one line. |
| `v`  | `K`                | Move selected block of text up one line. |
| `n`  | `J`                | Join current line with next and retain cursor. |
| `n`  | `<C-d>`            | Scroll half window down and center view. |
| `n`  | `<C-u>`            | Scroll half window up and center view. |
| `n`  | `n`                | Move to next search result and center view. |
| `n`  | `N`                | Move to previous search result and center view. |
| `n`  | `<leader>vwm`      | Starts the VimWithMe session. |
| `n`  | `<leader>svwm`     | Stops the VimWithMe session. |
| `x`  | `<leader>p`        | Deletes the selected text and pastes over it without overwriting the unnamed register. |
| `n`  | `<leader>y`        | Yanks (copies) the selection to the system clipboard in normal and visual mode. |
| `n`  | `<leader>Y`        | Yanks (copies) the entire line to the system clipboard, behaving like `Y` in Vim. |
| `n`  | `<leader>d`        | Deletes the selected text or the current line in normal mode without overwriting the unnamed register. |
| `i`  | `<C-c>`            | Maps Ctrl+c to Escape in insert mode, effectively exiting insert mode. |
| `n`  | `Q`                | Disables the Ex mode mapping to `Q`. |
| `n`  | `<C-f>`            | Opens a new tmux window with tmux-sessionizer. |
| `n`  | `<leader>f`        | Formats the buffer using the attached LSP server. |
| `n`  | `<C-k>`            | Moves to the next item in the quickfix list and centers the view. |
| `n`  | `<C-j>`            | Moves to the previous item in the quickfix list and centers the view. |
| `n`  | `<leader>k`        | Moves to the next item in the location list and centers the view. |
| `n`  | `<leader>j`        | Moves to the previous item in the location list and centers the view. |
| `n`  | `<leader>s`        | Initiates a search and replace for the word under the cursor across the entire file. |
| `n`  | `<leader>x`        | Makes the current file executable. |
| `n`  | `<leader>ee`       | Inserts an error check snippet in Go programming language. |
| `n`  | `<leader>mr`       | Executes the `CellularAutomaton make_it_rain` command. |
| `n`  | `<leader><leader>` | Sources the current file again. |

### Autocomplete

| Mode | Key Mapping | Description |
| ---- | ----------- | ----------- |
| `i`  | `<C-Space>` | Triggers autocomplete suggestions. |
| `i`  | `<C-p>` | Navigates to the previous item in autocomplete. |
| `i`  | `<C-n>` | Navigates to the next item in autocomplete. |
| `i`  | `<C-y>` | Confirms the selected autocomplete suggestion. |

### LSP Keybindings

| Mode | Key Mapping | Description |
| ---- | ----------- | ----------- |
| `n`  | `gd` | Jumps to the definition of the symbol under the cursor. |
| `n`  | `K` | Shows hover information for the symbol under the cursor. |
| `n`  | `<leader>vws` | Searches for workspace symbols. |
| `n`  | `<leader>vd` | Opens floating window with diagnostic information. |
| `n`  | `<leader>vca` | Shows code actions for the current context. |
| `n`  | `<leader>vrr` | Shows references for the symbol in a quickfix list. |
| `n`  | `<leader>vrn` | Renames the symbol across the workspace. |
| `i`  | `<C-h>` | Shows signature help for the function call at the cursor. |
| `n`  | `[d` | Goes to the next diagnostic message. |
| `n`  | `]d` | Goes to the previous diagnostic message. |

### Neogen Keybindings

| Mode | Key Mapping | Description |
| ---- | ----------- | ----------- |
| `n`  | `<leader>nf`| Generate documentation for a function. |
| `n`  | `<leader>nt`| Generate documentation for a type. |

### Neotest Keybindings

| Mode | Key Mapping | Description |
| ---- | ----------- | ----------- |
| `n`  | `<leader>tc` | Run tests for the current cursor location. |
| `n`  | `<leader>tf` | Run tests for the current file. |

### Snippets Keybindings

| Mode | Key Mapping | Description |
| ---- | ----------- | ----------- |
| `i`  | `<C-s>e`     | Expand the snippet at the cursor location. |
| `i`  | `<C-s>;`     | Jump to the next placeholder in the snippet. |
| `i`  | `<C-s>,`     | Jump to the previous placeholder in the snippet. |
| `i`  | `<C-E>`      | Change the current choice within a snippet. |

## Trouble Keybindings

| Mode | Key Mapping | Description |
| ---- | ----------- | ----------- |
| `n`  | `<leader>tt` | Toggle the Trouble list window. |
| `n`  | `[t`         | Jump to the next diagnostic item, skipping groups. |
| `n`  | `]t`         | Jump to the previous diagnostic item, skipping groups. |

## Zen Mode Keybindings

| Mode | Key Mapping | Description |
| ---- | ----------- | ----------- |
| `n`  | `<leader>zz` | Enter Zen Mode with 90% window width, wrapping disabled, line numbers and relative numbers enabled. Executes `ColorMyPencils()`. |
| `n`  | `<leader>zZ` | Enter Zen Mode with 80% window width, wrapping disabled, both line numbers and relative numbers disabled, `colorcolumn` set to `0`. Executes `ColorMyPencils()`. |
