## Clipboards

There are two types of clipboards in linux
* primary
* clipboard


### X applications

| Clipboard     | Copy            | Paste              |
|---------------|-----------------|--------------------|
| **Primary**   | Mouse selection | Mouse middle click |
| **Clipboard** | Ctrl - v        | Ctrl - p           |



### Terminal

| Clipboard     | Copy            | Paste                                  |
|---------------|-----------------|----------------------------------------|
| **Primary**   | Mouse selection | Mouse middle click <br> Shift + Insert |
| **Clipboard** | copy mode       | Shift + Ctrl + v                       |


### Vim

This is with
```vim
set clipboard=unnamed
" Only in neovim
noremap <A-p> "+p  
vnoremap <A-y> "+y
```

| Clipboard     | Copy                            | Paste            |
|---------------|---------------------------------|------------------|
| **Primary**   | Normal Copy                     | Normal Paste     |
| **Clipboard** | "+y <br> In visual mode Alt - y | "+p <br> Alt + p |

