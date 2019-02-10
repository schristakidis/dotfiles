export TERM=screen-256color
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

zshrc=$ZDOTDIR/.zshrc
sz() {source $zshrc}

vim()
{
    # Save current stty options.
    local STTYOPTS="$(stty -g)"

    # Disable intercepting of ctrl-s and ctrl-q as flow control.
    stty stop '' -ixoff -ixon

    # Execute vim.
    vim_command "$@"

    # Restore saved stty options.
    stty "$STTYOPTS"
}

vim_command()
{
    if (( $+commands[reattach-to-user-namespace] )); then
        # See: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
        command reattach-to-user-namespace vim "$@"
    else
        command vim "$@"
    fi
}


if [[ `uname` != 'Darwin' ]]; then
    eval `dircolors ~/.dotfiles/resources/dircolors-solarized/dircolors.ansi-dark`
fi

export LC_CTYPE=en_US.UTF-8