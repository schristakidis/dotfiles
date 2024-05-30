# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ZINIT_DIR="$HOME/.dotfiles/zsh/.zinit"
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# ### Added by Zinit's installer
if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZINIT_HOME/zinit.zsh"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="(cd|k exec|k logs) *"
# Load a few important annexes, without Turbo
# (this is currently required for annexes)

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/history-search-multi-word

zinit ice depth=1
zinit light romkatv/powerlevel10k

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

zinit wait lucid light-mode for \
    as"program" \
    pick"bin/git-dsf" \
        zdharma-continuum/zsh-diff-so-fancy \
    atload"bindkey '^P' history-substring-search-up \
        && bindkey '^N' history-substring-search-down  \
        && bindkey '^[[A' history-substring-search-up \
        && bindkey '^[[B' history-substring-search-down \
        && bindkey '^[OA' history-substring-search-up \
        && bindkey '^[OB' history-substring-search-down" \
            zsh-users/zsh-history-substring-search \
    softmoth/zsh-vim-mode \
    atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":\completion:*" list-colors “${(s.:.)LS_COLORS}”' \
        trapd00r/LS_COLORS \
    atload"_zsh_autosuggest_start" \
    atload"bindkey '^ ' autosuggest-accept" \
      zsh-users/zsh-autosuggestions \
    blockf \
      zsh-users/zsh-completions \
    PZT::modules/utility \
    as"completion" OMZP::pip/_pip \
    as"completion" OMZP::docker/completions/_docker \
    as"completion" OMZP::docker-compose/_docker-compose \
    as"completion" OMZP::httpie/_httpie \
    as"completion" OMZP::terraform/_terraform \
    as"completion" OMZP::fd/_fd \
    OMZP::aws \
    OMZP::istioctl \
    OMZP::helm \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    atload"fast-theme $HOME/.dotfiles/resources/fsh/mytheme.ini >/dev/null; eval $(zoxide init --cmd cd zsh)" \
      zdharma-continuum/fast-syntax-highlighting

zstyle ':prezto:module:editor' ps-context 'yes'
#
zstyle ':prezto:*:*' color 'yes'

zstyle ':completion:*' menu select
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

#
# for completions move the _completions_file to .local/share/zinit/completions/
# autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
