## Troubleshooting

<!-- vim-markdown-toc GFM -->

* [pyenv openssl problems (ubuntu)](#pyenv-openssl-problems-ubuntu)
* [Old Lenovo](#old-lenovo)
    * [slow wifi](#slow-wifi)
    * [Configure touchpad](#configure-touchpad)

<!-- vim-markdown-toc -->


## pyenv openssl problems (ubuntu)

```
mkdir ~/libssl1.0-dev
cd ~/libssl1.0-dev
apt-get download libssl1.0-dev
ar x libssl1.0-dev_1.0.2l-2+deb9u3_amd64.deb data.tar.xz
tar -xf data.tar.xz --strip-components=2
rm data.tar.xz
ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.2 ~/libssl1.0-dev/lib/x86_64-linux-gnu  (check that the lib versions are correct)
ln -s /usr/lib/x86_64-linux-gnu/libssl.so.1.0.2 ~/libssl1.0-dev/lib/x86_64-linux-gnu
CFLAGS="-I${HOME}/libssl1.0-dev/include -I${HOME}/libssl1.0-dev/include/x86_64-linux-gnu" LDFLAGS="-L${HOME}/libssl1.0-dev/lib/x86_64-linux-gnu" pyenv install 3.4.8
```

## Old Lenovo
### slow wifi

Add to /etc/modprobe.d/iwlwifi.conf (create if necessary)
```sh
options iwlwifi swcrypto=1 power_save=0 d0i3_disable=0 uapsd_disable=0 11n_disable=8
```


### Configure touchpad
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
