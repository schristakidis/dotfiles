export TERM=screen-256color

export GOPATH="$HOME/go"
export CARGOPATH="$HOME/.cargo/bin"

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="$PATH:$GOPATH/bin:$CARGOPATH"

export EDITOR='nvim'
export VISUAL='st nvim'
export PAGER='less'

zshrc=$ZDOTDIR/.zshrc
sz() {source $zshrc}

export LC_CTYPE=en_US.UTF-8

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

alias vim="nvim"
alias joplin-cli="joplin --profile ~/.config/joplin-desktop"
