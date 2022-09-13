export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if [ -d $PYENV_ROOT ]; then
    eval "$(pyenv init -)";
    eval "$(pyenv virtualenv-init -)"
    # pyenv virtualenvwrapper;
fi
