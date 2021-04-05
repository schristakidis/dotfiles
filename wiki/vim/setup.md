## Extra installs

### Spellsitter

- hunspell
- hunspell-en_us

### Telescope

- bat
- fd
- ripgrep

### Nvim-web-devicons

- Nerd Fonts

###  nvim-jqx 

- jq
- yq (for yaml)


### autoformater

#### json
```sh
npm install -g js-beautify
```

#### python
- yapf
```sh
pip install yapf
```
- black

Only for python 3.6+ but it can format python2 also. Does not support range formatting

```sh
workon neovim3
pip install black
ln -s ~/.local/bin/black `which black`
deactivate
```
