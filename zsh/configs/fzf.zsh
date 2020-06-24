if [ -d $HOME/.fzf ]; then
    source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null
    source "$HOME/.fzf/shell/key-bindings.zsh" 2> /dev/null
else
    source /usr/share/fzf/completion.zsh 2> /dev/null
    source /usr/share/fzf/key-bindings.zsh 2> /dev/null
fi

if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    export PATH="$PATH:$HOME/.fzf/bin"
fi

export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='fd --type f --hidden --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"


fzgrep() {
    ag --nobreak --nonumbers --noheading . | fzf 
}

fzpac() {
    local packages
    echo "Need to run pacman -Fy"
    packages="$(pacman -Slq | fzf -m --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")')"
    pacman -Qi "$packages" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo 'Package is allready installed'
    else
        echo 'Package is not installed'
        pacman -Si "$packages"
        sudo pacman -S "$packages"
    fi
}

fzyac() {
    local packages
    packages="$(yay -Slq | fzf -m --preview 'yay -Si {1}')"
    pacman -Qi "$packages" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo 'Package is allready installed'
    else
        echo 'Package is not installed'
        yay -Si "$packages"
        yay -S "$packages"
    fi
}

fzkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}


fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
        fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


export LPASS_USER='schristakidis@gmail.com'
flpass() {
    local site
    lpass login --trust $LPASS_USER
    site=$(lpass ls | fzf --height=40%  | awk '/\[id\:/ {print $NF}' | sed 's/\]//')
    lpass show --url --username $site
    lpass show -cp $site
    # lpass logout -f
}

fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

y() {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
