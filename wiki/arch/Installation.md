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

## Configure touchpad
[instructions](https://wiki.archlinux.org/index.php/Touchpad_Synaptics)

Copy snippet to /etc/X11/xorg.conf.d/70-synaptics.conf
```cfg
Section "InputClass"
    Identifier "touchpad"
    Driver "synaptics"
    MatchIsTouchpad "on"
        Option "TapButton1" "1"
        Option "TapButton2" "3"
        Option "TapButton3" "2"
        Option "VertEdgeScroll" "on"
        Option "VertTwoFingerScroll" "on"
        Option "HorizEdgeScroll" "on"
        Option "HorizTwoFingerScroll" "on"
        Option "CircularScrolling" "off"
        Option "PalmDetect" "1"
        Option "PalmMinWidth" "8"
        Option "PalmMinZ" "100"
EndSection
```




