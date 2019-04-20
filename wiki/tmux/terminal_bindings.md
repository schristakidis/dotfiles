### Readline terminal bindings (emacs)

#### General

| Binding | Description      |
|---------|------------------|
| Ctrl+l  | Clear the screen |

#### Cursor Movement

| Binding | Description                                              |
|---------|----------------------------------------------------------|
| Ctrl+b  | Move cursor one character to the left                    |
| Ctrl+f  | Move cursor one character to the right                   |
| Alt+b   | Move cursor one word to the left                         |
| Alt+f   | Move cursor one word to the right                        |
| Ctrl+a  | Move cursor to start of the line (In tmux Ctrl+a Ctrl+a) |
| Ctrl+e  | Move cursor to end of the line                           |

#### Copy & Paste

| Binding    | Description                                       |
|------------|---------------------------------------------------|
| Ctrl+u     | Cut everything from line start to cursor          |
| Ctrl+k     | Cut everything from the cursor to end of the line |
| Alt+d      | Cut the current word after the cursor             |
| Ctrl+w     | Cut the current word before the cursor            |
| Ctrl+y     | Paste the previous cut text                       |
| Alt+y      | Paste the second latest cut text                  |
| Alt+Ctrl+y | Paste the first argument of the previous command  |
| Alt+./_    | Paste the last argument of the previous command   |
    
##### History

| Binding | Description                           |
|---------|---------------------------------------|
| Ctrl+p  | Move to the previous line             |
| Ctrl+n  | Move to the next line                 |
| Ctrl+s  | Search                                |
| Ctrl+r  | Reverse search                        |
| Ctrl+j  | End search                            |
| Ctrl+g  | Abort search (restores original line) |
| Alt+r   | Restores all changes made to line     |

#### Completion

| Binding | Description                     |
|---------|---------------------------------|
| Tab     | Auto-complete a name            |
| Alt+?   | List all possible completions   |
| Alt+*   | Insert all possible completions |
