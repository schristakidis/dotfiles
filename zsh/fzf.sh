source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export FZF_TMUX=1
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"


fzgrep() {
    ag --nobreak --nonumbers --noheading . | fzf 
}

fzpac() {
    local packages
    packages="$(pacman -Ssq | fzf --height=40%)"
    pacman -Si "$packages"
    sudo pacman -S "$packages"
}

fkill() {
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
    lpass login $LPASS_USER
    site=$(lpass ls | fzf --height=40%  | awk '/\[id\:/ {print $NF}' | sed 's/\]//')
    lpass show --url --username $site
    lpass show -cp $site
    lpass logout -f
}
