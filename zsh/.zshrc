# Reset terminal state
[[ -o interactive ]] && stty sane 2>/dev/null

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Aliases — editor
alias vim='nvim'

# Aliases — git
alias gst='git status'
alias gd='git diff'

# Aliases - navigation
alias t='tmux new-session -A -s local'

# Atuin
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# Homebrew
if command -v brew &> /dev/null; then
  eval "$(brew shellenv zsh)"
fi

# mise
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi
