# User-local CLI tools
. "$HOME/.local/bin/env"
export PATH="/opt/homebrew/bin:$PATH"

export VISUAL="nvim"
export EDITOR="nvim"
export GH_EDITOR="nvim"

bindkey -e

bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word

bindkey "\e^?" backward-kill-word
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.dual-graph"

# linear issue create: Short hand to create linear issue and open description in nvim
lic() {
local title="$1"
 
  if [ -z "$title" ]; then
    echo "❌ Error: You must provide a title."
    echo "Usage: lic \"Issue Title\" [--project \"Name\"] [--team XXX]"
    return 1
  fi

  shift # Remove the title from the list of arguments

  # Create a temp markdown file
  local tmpfile=$(mktemp /tmp/linear-issue-XXXXXX.md)

  # Open Neovim
  nvim "$tmpfile"

  # Read the file contents
  local desc=$(cat "$tmpfile")

  # If the file is empty (you aborted), cancel the creation
  if [ -z "$desc" ]; then
    echo "⚠️ Description is empty. Aborting issue creation."
    rm "$tmpfile"
    return 1
  fi

  # Create the issue passing the title, the nvim description, and flags
  linear issue create --title "$title" --description "$desc" "$@"

  rm "$tmpfile"
}
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
source "/Users/danvicente/.config/stax/shell-setup.sh" # stax shell-setup
