## Guides

<!-- vim-markdown-toc GFM -->

* [Default Applications](#default-applications)
    * [Default web browser](#default-web-browser)
* [Command-not-found](#command-not-found)
* [Font Awesome](#font-awesome)
* [Set Keyboard Languages](#set-keyboard-languages)
* [Change CAPS key](#change-caps-key)
* [Add certificate](#add-certificate)

<!-- vim-markdown-toc -->
## Default Applications

Get mime type of a file

```sh
xdg-mime query filetype <filepath>
```

Get default application for mime type

```sh
xdg-mime query default <mime type>
```

Set default application for mime type

```sh
xdg-mime default <desktop file> <mime type>
```

Configuration file in ```$HOME/.config/mimeapps.list```


### Default web browser

```sh
xdg-mime query default x-scheme-handler/http
xdg-mime query default x-scheme-handler/https

xdg-mime default firefox.desktop x-scheme-handler/http
xdg-mime default firefox.desktop x-scheme-handler/http
```


## Command-not-found

Install ```pkgfile```

Instructions [Arch pkgfile](https://wiki.archlinux.org/index.php/Pkgfile#Installation)

## Font Awesome
[cheat sheet](https://fontawesome.com/cheatsheet)

## Set Keyboard Languages
```sh
localectl --no-convert set-x11-keymap us,gr "", "" grp:alt_shift_toggle
```

## Change CAPS key
Add to .xprofile
```sh
setxkbmap -option caps:ctrl_modifier
```

## Add certificate

```sh
sudo cp crt /etc/ca-certificates/trust-source/anchors
sudo trust extract-compat
```
