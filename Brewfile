# Only what the configs in this repo use.

tap "cesarferreira/tap"
tap "schpet/tap", trusted: true

# kitty/ (kitty.app may already exist from kitty's own installer; the cask refuses to overwrite it)
cask "kitty" unless File.exist?("/Applications/kitty.app")

# tmux/
brew "tmux"

# nvim/ (LazyVim, plus what Mason needs to install language servers)
brew "neovim"
brew "ripgrep"
brew "fd"
brew "fzf"
brew "tree-sitter-cli"
brew "luarocks"
brew "node"

# git/
brew "gh"
brew "git-xet"

# zsh/
brew "cesarferreira/tap/stax", trusted: true
brew "schpet/tap/linear"
brew "libpq"
cask "orbstack"

# btop/, htop/, visidata/
brew "btop"
brew "htop"
brew "visidata"

# Links the folders in this repo into $HOME
brew "stow"
