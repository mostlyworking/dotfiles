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

lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
source "/Users/danvicente/.config/stax/shell-setup.sh" # stax shell-setup


# bun completions
[ -s "/Users/danvicente/.bun/_bun" ] && source "/Users/danvicente/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


function agent() {
    local tmux_sess=$(tmux display-message -p "#S" 2>/dev/null || echo "default")
    local profile_name=$(echo "$tmux_sess" | tr ' .' '-')
    
    if [ "$profile_name" != "default" ] && [ ! -d "$HOME/.hermes/profiles/$profile_name" ]; then
        echo "🚀 First time in this tmux session! Creating isolated profile: $profile_name"
        hermes profile create "$profile_name" > /dev/null
        cp "$HOME/.hermes/config.yaml" "$HOME/.hermes/profiles/$profile_name/config.yaml" 2>/dev/null
        cp "$HOME/.hermes/.env" "$HOME/.hermes/profiles/$profile_name/.env" 2>/dev/null
    fi
    
    echo "🧠 Context locked to: $profile_name"
    
    local model_name=""
    local passed_args=()
    
    while [[ $# -gt 0 ]]; do
        if [[ "$1" == "--model" && -n "$2" ]]; then
            model_name="$2"
            shift 2
        else
            passed_args+=("$1")
            shift
        fi
    done
    
    if [[ -n "$model_name" ]]; then
        ollama launch hermes --model "$model_name" -- -p "$profile_name" -m "$model_name" chat "${passed_args[@]}"
    else
        ollama launch hermes -- -p "$profile_name" chat "${passed_args[@]}"
    fi
}
