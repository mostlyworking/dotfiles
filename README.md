# dotfiles

macOS setup: kitty, tmux, Neovim (LazyVim), zsh, git, btop, htop and VisiData.

## New machine

```sh
git clone https://github.com/mostlyworking/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

`install.sh` is safe to re-run. It:

1. installs Homebrew if missing, then everything in `Brewfile` (it never upgrades what is already installed);
2. installs uv and bun with their own installers if missing;
3. symlinks each folder into `$HOME` with GNU Stow (it stops without changing anything if a real file is in the way);
4. installs the tmux plugins and the Neovim plugins pinned in `nvim/.config/nvim/lazy-lock.json`.

One manual step: the kitty font, Input Mono Compressed, can't be redistributed. Download it from
<https://input.djr.com/download/> and install the `InputMonoCompressed-*.ttf` files.

## Layout

Each top-level folder mirrors `$HOME`, for example `tmux/.tmux.conf` becomes `~/.tmux.conf`.
To add a config, put it at the same path inside a new or existing folder and re-run `install.sh`.
