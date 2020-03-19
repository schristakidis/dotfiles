bindkey -M emacs 'jj' vi-cmd-mode
bindkey -M emacs "^[k" kill-line
bindkey -M emacs "^[l" clear-screen

# exchange alt and control f/b bindings
bindkey "^[f" forward-char
bindkey "^[b" backward-char

bindkey "^f" forward-word
bindkey "^b" backward-word

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
