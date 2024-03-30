export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [ -d $PYENV_ROOT ]; then
    eval "$(pyenv init -)";
    eval "$(pyenv virtualenv-init -)"
    # pyenv virtualenvwrapper;
fi
