## Bindings
### Alacritty

 * Enter VI mode -> ``Ctrl - Shift - Space ``

### Vim

```vim
map("v", "<C-y>", "\"+y")
map({ "n", "v" }, "<A-p>", "\"+p")
```

## Copying 

| Clipboard     | Alacritty       | Tmux                    | Vim             | Apps             |
|---------------|-----------------|-------------------------|-----------------|------------------|
| **Primary**   | Mouse selection | Shift + Mouse Selection | Normal yank     | Visual Selection |
| **Clipboard** | (VI) visual + y | Mouse Selection         | (Visual) Ctrl-y | Ctrl-c           |
|               |                 | (Copy Mode) visual + y  |                 |                  |



## Pasting

| Clipboard     | Alacritty              | Tmux               | Vim                | Apps         |
|---------------|------------------------|--------------------|--------------------|--------------|
| **Primary**   | Middle Click           | Shift Middle Click | Normal pasting     | Middle click |
|               | Cltr-Shift-y           | Cltr-Shift-y       |                    |              |
| **Clipboard** | Ctrl-Shift-v           | Ctrl-Shift-v       | Alt - p            | Ctlr-v       |


