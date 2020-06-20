## Extra installs

### coc

- docker 
```sh
npm install -g dockerfile-language-server-nodejs
```
- bash 
```sh
npm i -g bash-language-server
```
- terraform [build](https://github.com/juliosueiras/terraform-lsp)


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
only for python 3.6+ but it can format python2 also. Does not support range formatting
```sh
workon neovim3
pip install black
ln -s ~/.local/bin/black `which black`
deactivate
```
