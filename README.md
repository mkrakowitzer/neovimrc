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

Keymaps are set using the `which-key` plugin
