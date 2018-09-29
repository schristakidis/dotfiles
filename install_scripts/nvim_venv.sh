#!/usr/bin/zsh

pyenv install 3.6.1
pyenv install 2.7.9

pyenv virtualenv 2.7.9 neovim2
pyenv virtualenv 3.6.1 neovim3

pyenv activate neovim3
pip install flake8 pylint pyflakes yapf isort jedi neovim
mkdir -p $HOME/bin
ln -s `pyenv which flake8` $HOMW/bin/flake8 
ln -s `pyenv which pylint` $HOMW/bin/pylint 
ln -s `pyenv which yapf` $HOMW/bin/yapf 
ln -s `pyenv which isort` $HOMW/bin/isort 
pyenv deactivate

pyenv activate neovim2
pip install flake8 pylint pyflakes yapf isort jedi neovim
pyenv deactivate

