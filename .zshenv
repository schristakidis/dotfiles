export XDG_CONFIG_HOME="$HOME/.config"
export DOTDIR=$HOME/.dotfiles
export ZSH_CACHE_DIR=$HOME/.local/share/zinit/
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export PATH="$HOME/.bin:$PATH"
export TERMINAL=alacritty

# Normalize exotic TERM values (e.g. terminal-specific ones) over ssh
if [[ -n "$SSH_CONNECTION" && "$TERM" != screen* && "$TERM" != tmux* && "$TERM" != xterm* ]]; then
  export TERM=xterm-256color
fi
