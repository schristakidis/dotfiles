# Initial steps
- Copy ssh keys
- Install zinit
    ```sh
    curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh
    ```
- Install initial deps and clone dotfiles
    ```sh
    pacman -S stow zsh git
    git clone git@github.com:schristakidis/dotfiles.git .dotfiles
    ```
- Checkout the correct branch and run
    ```sh
    cd .dotfiles && stow .
    ```
- Install pyenv and dependencies
    ```sh
    curl https://pyenv.run | bash
    pacman -S --needed base-devel openssl zlib xz tk
    ```
- Install yay
    ```sh
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    ```


## Dual boot windows with grub
- Mount the windows efi partition. It should be the first Windows partiotion
- install os-prober
- run os-prober as root
- In `/etc/default/grub` set `GRUB_DISABLE_OS_PROBER=false`
- Run
    ```sh
    grub-mkconfig -o /boot/grub/grub.cfg
    grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
    ```

## Nvim setup
- Install neovim
- Create a virtualenv with the latest python version and install pynvim
    ```sh
    pyenv install 3.11.8
    pyenv virtualenv 3.11.8 neovim
    pyenv activate neovim
    pip install pynvim
    pyenv deactivate
    ```
- Install dependencies
    - fzf
    - tmux
    - npm
    - wget
    - cargo
    - luarocks
    - pip
    - wl-clipboard
    - yarn
    - ripgrep
    - fd

## Fonts
    - ttf-font-awesome
    - ttf-jetbrains-mono-nerd
    - noto-fonts-emoji
    - ttf-nerd-fonts-symbols-mono

## Nvidia
- Install drivers
    ```sh
    packman -S linux-headers nvidia-dkms
    ```
- In `/etc/mkinitcpio.conf` add in the `MODULES` section `nvidia nvidia_modeset nvidia_uvm nvidia_drm`
- Create a new file `/etc/modprobe.d/nvidia.conf`
    ```
    options nvidia-drm modeset=1
    options nvidia-drm fbdev=1
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    ```
- In `/etc/default/grub` add `nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1` at the end of `GRUB_CMDLINE_LINUX_DEFAULT`
- Run again
    ```sh
    sudo grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
    sudo grub-mkconfig -o /boot/efi/EFI/arch/grub.cfg
    ```
- Enable services 
    ```sh
    systemctl enable nvidia-suspend.service
    systemctl enable nvidia-hibernate.service
    systemctl enable nvidia-resume.service
    ```
- Run `sudo /usr/bin/mkinitcpio -P`
- Create the file `/etc/packman.d/hooks/nvidia.hook`
    ```
    [Trigger]
    Operation=Install
    Operation=Upgrade
    Operation=Remove
    Type=Package
    # Uncomment the installed NVIDIA package
    Target=nvidia-dkms  # this is me
    #Target=nvidia
    #Target=nvidia-open
    #Target=nvidia-lts
    Target=linux
    # Change the linux part above if a different kernel is used

    [Action]
    Description=Update NVIDIA module in initcpio
    Depends=mkinitcpio
    When=PostTransaction
    NeedsTargets
    Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
    ```

- Install some extra packages
    - qt5-wayland
    - qt5ct 
    - libva 
    - libva-nvidia-driver-gi

- If wayland sessions are not presented in gdm try
    ```sh
    ln -s /dev/null /etc/udev/rules.d/61-gdm.rules
    ```

## Install sway
### Dependencies
    - sway
    - waybar(-git)
    - swayidle
    - swayr
    - swaylock
    - swaybg
    - playerctl
    - grim
    - grimshot
    - slurp
    - dunst
    - mate-polkit
    - swappy
    - wlsunset
    - wl-clipboard
    - cliphist
    - pcmanfm
    - network-manager-applet
    - blueman
    - 1password
    - 1password-cli
    - pass
    - psensor
    - autotiling
    - nwg-look
    - nwg-displays
    - nwg-bar-bin
    - nwg-drawer-bin
    - calcurse
    - pulsemixer
    - pavucontrol
    - pamixer
    - brightnessctl
    - wofi
    - rofi
    - foot
    - alacritty
    - kitty
    - less
    - pipewire
    - wireplumber
    - xdg-desktop-portal-wlr
    - xdg-desktop-portal-gtk
    - yaru-gtk-theme
    - yaru-icon-theme
    - yaru-remix-icon-theme
    - ydotool
    - python-dbus-next
    - python-i3ipc
    - python-psutil
    - python-tenacity
    - python-xlib
    - python-requests
    - checkupdates-with-aur
    - keyd

## Install Hyperland
### Dependencies
The same with sway but remove `xdg-desktop-portal-wlr` and install `xdg-desktop-portal-hyprland`
- pyprland

## Misc
### Set default applications
Crate a file `.config/mimeapps.list`
```
[Default Applications]
application/pdf=org.gnome.Evince.desktop;
application/xhtml+xml=firefox.desktop;org.gnome.Epiphany.desktop;
text/html=firefox.desktop;org.gnome.Epiphany.desktop;
text/xml=firefox.desktop;
x-scheme-handler/http=firefox.desktop;org.gnome.Epiphany.desktop;
x-scheme-handler/https=firefox.desktop;org.gnome.Epiphany.desktop;
application/msword=libreoffice-writer.desktop
application/vnd.openxmlformats-officedocument.wordprocessingml.document=libreoffice-writer.desktop
```

The default file can be found at `/usr/share/applications/mimeinfo.cache`

### Firefox pseudo fullscreen
Set in `about:config` `full-screen-api.ignore-widgets` to `true`


### Keyd
https://github.com/rvaiya/keyd

- install keyd
- set the config file at ``/etc/keyd/default.conf``
```
[ids]

*

[main]

# Maps capslock to escape when pressed and control when held.
capslock = overload(control, esc)
```
- sudo systemctl enable --now keyd


### MPS VPN
```sh
pyenv virtualenv 3.11.8 opensso
pyenc activate opensso
pip install openconnect-sso
pip install requests==2.28.2
```

Add these at `~/.pyenv/versions/opensso/lib/python3.11/site-packages/openconnect_sso/app.py`
```python
import requests
requests.packages.urllib3.util.ssl_.DEFAULT_CIPHERS += ':!DH'
```

Also comment out the lines for the totp `if credentials and not credentials.totp`

In `~/.config/openconnect-sso/config.toml` change the otp sections to
```
[[auto_fill_rules."https://*"]]
selector = "input[data-report-event=Signin_Submit]"
action = "click"

[[auto_fill_rules."https://*"]]
selector = "input[type=tel]"
fill = "totp"
```

### Tmux and 1password
In `~/.config/tmux/plugins/tmux-1password/scripts/main.sh` change in fzp_opts ``execute`` to ``become``
```sh
local -ra fzf_opts=(
    --no-multi
    "--header=enter=password, ctrl-u=totp"
    --bind "enter:become(echo pass,{+})+abort"
    --bind "ctrl-u:become(echo totp,{+})+abort"
)

```

Add in `~/.config/tmux/plugins/tmux-1password/scripts/utils/clipboard.sh`
```
elif [[ "$(uname)" == "Linux" ]] && cmd::exists "wl-copy"; then
echo -n "$1" | wl-copy

elif [[ "$(uname)" == "Linux" ]] && cmd::exists "wl-copy"; then
tmux run-shell -b "sleep $SEC && wl-copy -c"
```
