# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


ZINIT_DIR="$HOME/.dotfiles/zsh/.zinit"
### Added by Zinit's installer
if [[ ! -f $ZINIT_DIR/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZINIT_DIR" && command chmod g-rwX "$ZINIT_DIR"
    command git clone https://github.com/zdharma/zinit "$ZINIT_DIR" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZINIT_DIR/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit wait lucid light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

#
zinit ice wait"0a" lucid \
    atload="bindkey '^P' history-substring-search-up \
        && bindkey '^N' history-substring-search-down  \
        && bindkey '^[[A' history-substring-search-up \
        && bindkey '^[[B' history-substring-search-down" 
zinit light "zsh-users/zsh-history-substring-search"
    #
# ### End of Zinit's installer chunk
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
  atload"fast-theme $HOME/.dotfiles/fsh/mytheme.ini >/dev/null" \
      zdharma/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
      zinit light zsh-users/zsh-completions \
  as"program" pick"bin/git-dsf" \
      zinit light zdharma/zsh-diff-so-fancy \
  PZT::modules/utility \
  as"completion" OMZP::pip/_pip \
  as"completion" OMZP::docker/_docker \
  as"completion" OMZP::docker-compose/_docker-compose \
  as"completion" OMZP::httpie/_httpie \
  OMZP::fasd

zinit load softmoth/zsh-vim-mode

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice lucid wait"1"
zinit snippet $HOME/.dotfiles/zsh/virtual.zsh

for zsh_source in $ZDOTDIR/configs/*.zsh; do
    source $zsh_source
done

if [ -d $ZDOTDIR/local ]
then
    for zsh_source in "$(ls $ZDOTDIR/local)"; do
        if [[ $zsh_source =~ \.zsh$ ]]
        then
            source $ZDOTDIR/local/$zsh_source
        fi
    done
fi

zstyle ':prezto:module:editor' ps-context 'yes'
#
zstyle ':prezto:*:*' color 'yes'

zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh
