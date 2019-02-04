export PYENV_ROOT="$HOME/.pyenv"

if which virtualenvwrapper.sh > /dev/null; then
    . $(which virtualenvwrapper.sh);
fi

if [ -d $PYENV_ROOT ]; then
    export PATH="$HOME/.pyenv/bin:$PATH";
    eval "$(pyenv init -)";
    eval "$(pyenv virtualenv-init -)"
    pyenv virtualenvwrapper_lazy;
fi
