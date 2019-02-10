# zmodload zsh/zprof
source ~/.zplug/init.zsh
source $ZDOTDIR/prezto.zsh

zplug modules/directory, from:prezto
zplug modules/command-not-found, from:prezto
zplug modules/utility, from:prezto
zplug zdharma/fast-syntax-highlighting, defer:0
zplug supercrabtree/k
zplug modules/history-substring-search, from:prezto, defer:1
zplug modules/prompt, from:prezto, defer:2
zplug zsh-users/zsh-completions, defer:2
zplug plugins/pip, from:oh-my-zsh
zplug plugins/httpie, from:oh-my-zsh
zplug plugins/docker, from:oh-my-zsh
zplug plugins/docker-compose, from:oh-my-zsh
zplug zdharma/zsh-diff-so-fancy, as:command, use:'bin/*'
zplug "clvv/fasd", as:command, use:fasd
zplug "plugins/fasd", from:oh-my-zsh, if:"(( $+commands[fasd] ))", on:"clvv/fasd"
zplug zplug/zplug #, hook-build:'zplug --self-manage'

# Install packages that have not been installed yet
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     else
#         echo
#     fi
# fi
#
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

fast-theme $HOME/.dotfiles/fsh/mytheme.ini > /dev/null
