if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
fi
export LC_CTYPE=en_US.UTF-8

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
    /usr/local/{bin,sbin}
    $path
)

export TERM=screen-256color

export GOPATH="$HOME/go"
export CARGOPATH="$HOME/.cargo/bin"

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="$PATH:$GOPATH/bin:$CARGOPATH"

export EDITOR='nvim'
export VISUAL='st nvim'
export PAGER='less'

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
    export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
    export TMPDIR="/tmp/$LOGNAME"
    mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"


zshrc=$ZDOTDIR/.zshrc
sz() {source $zshrc}

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
elif [ -f $HOME/.nvm/nvm.sh ]; then
    source $HOME/.nvm/nvm.sh
fi

if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

alias vim="nvim"
alias tmux="TERM=xterm-256color tmux -2"
alias joplin-cli="joplin --profile ~/.config/joplin-desktop"
alias k8s="kubectl"

bindkey -v

# exchange alt and control f/b bindings
bindkey "^[f" forward-char
bindkey "^[b" backward-char

bindkey "^f" forward-word
bindkey "^b" backward-word

export AWS_PROFILE=staging
