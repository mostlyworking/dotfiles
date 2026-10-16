#!/usr/bin/env bash
# Sets up a Mac from this repo. Safe to re-run: every step skips what is already done.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

step() { printf '\n==> %s\n' "$1"; }

step "Homebrew"
if ! command -v brew >/dev/null 2>&1 && [ ! -x /opt/homebrew/bin/brew ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file "$DOTFILES/Brewfile" --no-upgrade

step "uv and bun"
# Their own installers, not Homebrew. Shell PATH setup for both already lives in zsh/.zshrc.
command -v uv >/dev/null 2>&1 || [ -x "$HOME/.local/bin/uv" ] ||
  curl -LsSf https://astral.sh/uv/install.sh | sh
command -v bun >/dev/null 2>&1 || [ -x "$HOME/.bun/bin/bun" ] ||
  curl -fsSL https://bun.sh/install | bash

step "Symlinks"
# Without ~/.config, stow would link the whole directory into this repo.
mkdir -p "$HOME/.config"
packages=()
for dir in "$DOTFILES"/*/; do
  packages+=("$(basename "$dir")")
done
# Stow changes nothing if any target is an existing real file; it lists the conflicts instead.
if ! stow --dir "$DOTFILES" --target "$HOME" --restow "${packages[@]}"; then
  echo "Move the conflicting files above out of the way (or into this repo) and re-run." >&2
  exit 1
fi

step "tmux plugins"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

step "Neovim plugins"
# Installs the exact plugin versions pinned in lazy-lock.json.
nvim --headless "+Lazy! restore" +qa

step "This repo's commit author"
git -C "$DOTFILES" config user.name mostlyworking

step "Font"
if compgen -G "$HOME/Library/Fonts/InputMonoCompressed-*" >/dev/null || compgen -G "/Library/Fonts/InputMonoCompressed-*" >/dev/null; then
  echo "Input Mono Compressed is installed."
else
  echo "Manual step: download Input Mono from https://input.djr.com/download/,"
  echo "then install the InputMonoCompressed-*.ttf files (double-click, or copy to ~/Library/Fonts)."
fi

printf '\nDone. Open a new terminal to load the shell config.\n'
