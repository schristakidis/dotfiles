## Clipboards

There are two types of clipboards in linux
* primary
* clipboard


### X applications

| Clipboard     | Copy            | Paste              |
|---------------|-----------------|--------------------|
| **Primary**   | Mouse selection | Mouse middle click |
| **Clipboard** | Ctrl - C        | Ctrl - V           |



### St Terminal

| Clipboard     | Copy            | Paste                           |
|---------------|-----------------|---------------------------------|
| **Primary**   | Mouse selection | Mouse middle click <br> Alt + Y |
| **Clipboard** | <t>             | Alt + V                         |

### Tmux St Terminal

| Clipboard     | Copy                           | Paste                           |
|---------------|--------------------------------|---------------------------------|
| **Primary**   | copy mode <br> Mouse selection | Mouse middle click <br> Alt + Y |
| **Clipboard** | copy mode                      | Alt + V                         |

### Vim

This is with
```vim
set clipboard=unnamed
" Only in neovim
noremap <A-v> "+p  
vnoremap <A-p> "+y
```

| Clipboard     | Copy                            | Paste            |
|---------------|---------------------------------|------------------|
| **Primary**   | Normal Copy                     | Normal Paste     |
| **Clipboard** | "+y <br> In visual mode Alt + P | "+p <br> Alt + V |
