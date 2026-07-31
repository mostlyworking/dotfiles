# User-local CLI tools
. "$HOME/.local/bin/env"
export PATH="/opt/homebrew/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

export VISUAL="nvim"
export EDITOR="nvim"
export GH_EDITOR="nvim"

bindkey -e

bindkey "\e[1;3D" backward-word
bindkey "\e[1;3C" forward-word

bindkey "\e^?" backward-kill-word
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.dual-graph"


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

  # Create the issue passing the title, the nvim description, and any other flags you typed
  linear issue create --title "$title" --description "$desc" "$@"

  # Clean up the temp file
  rm "$tmpfile"
}
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
