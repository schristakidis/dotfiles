### slow wifi on lenovo

Add to /etc/modprobe.d/iwlwifi.conf (create if necessary)
```sh
options iwlwifi swcrypto=1 power_save=0 d0i3_disable=0 uapsd_disable=0 11n_disable=8
```

probably the last flag did the trick
