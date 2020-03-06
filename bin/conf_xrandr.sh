_bspwm_laptop=
_bspwm_first_screen=
_bspwm_second_screen=

if [ -n "$(xrandr --query | grep -w 'connected' | grep 'eDP-1')" ]; then
	_bspwm_laptop='1'
    _bspwm_first_screen=$(xrandr --query |grep -w connected |grep 'eDP-1' | cut -d' ' -f1)
    _bspwm_second_screen=$(xrandr --query |grep -w connected |grep -v 'eDP-1' | cut -d' ' -f1)
else
    _bspwm_first_screen='HDMI-1'
    _bspwm_second_screen='HDMI-2'
fi

_laptop() {
    [ ! -z "$_bspwm_laptop" ] && return 0 || return 1
}

_multi_laptop() {
    _laptop && [ ! -z "$_bspwm_second_screen" ]  && return 0 || return 1
}

_mps() {
    [ -z "$_bspwm_laptop" ] && return 0 || return 1
}

_mutlihead() {
    if _multi_laptop or _mps; then
        return 0
    else
        return 1
    fi
}


_conf_monitors() {
    if _laptop; then
        $HOME/.dotfiles/screenlayout/p1.sh
    elif _multi_laptop; then
        $HOME/.dotfiles/screenlayout/p1_multi.sh
    else
        $HOME/.dotfiles/screenlayout/mps.sh
    fi
}

