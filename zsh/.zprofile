# User-local CLI tools
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# OrbStack command-line tools and integration
source "$HOME/.orbstack/shell/init.zsh" 2>/dev/null || :
