## Dependencies

Packages:
- swaymsg
- systemctl
- dbus-update-activation-environment
- swayidle
- swayrd
- light
- playerctl
- swaylock
- grim
- ffmpeg
- dunst
- mate-polkit
- swappy
- wlsunset
- wl-clipboard
- cliphist
- pcmanfm
- nm-applet
- blueman-applet
- 1passsword
- sway-bg
- psensor
- autotiling
- nwg-look
- nwg-displays
- nwg-drawer
- nwg-bar
- calcurse
- pulsemixer
- pavucontrol
- pamixer
- brightnessctl
- wofi
- foot
- yaru-theme

Python:
- dbus-next
- i3ipc
- psutil
- tenacity
- python-xlib

## Setup Sway
```sh
./install-systemd
sudo cp start-sway /usr/bin
cp system/custom-sway.desktop /usr/share/wayland-sessions/
```

### User Services
```sh
systemd --user enable --now system/waybar.service
systemd --user enable --now system/swayidle.service
systemd --user enable --now system/swayrd.service
```
