# Environment variables sourced by all zsh invocations

. "$HOME/.cargo/env"

export LC_ALL=en_US.UTF8
export EDITOR='nvim'
export GOPROXY=direct

# PATH
for dir in \
  /home/linuxbrew/.linuxbrew/bin \
  /opt/homebrew/bin \
  $HOME/.opencode/bin \
  $HOME/.local/bin \
  $HOME/.local/share/mise/shims \
; do
  [[ -d $dir ]] && export PATH="$dir:$PATH"
done
