source ~/.zplug/init.zsh
source $ZDOTDIR/prezto.zsh

# zplug mafredri/zsh-async, from:github
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug modules/directory, from:prezto
zplug modules/command-not-found, from:prezto
zplug modules/utility, from:prezto
zplug modules/syntax-highlighting, from:prezto, defer:0
zplug modules/history-substring-search, from:prezto, defer:1
zplug modules/prompt, from:prezto, defer:2
zplug zsh-users/zsh-completions, defer:2

zplug load

for zsh_source in $ZDOTDIR/configs/*.zsh; do
  source $zsh_source
done

for zsh_source in $ZDOTDIR/local/*.zsh; do
    source $zsh_source
done

# completions
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit

# ensure_tmux_is_running
