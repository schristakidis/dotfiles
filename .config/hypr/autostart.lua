-- ============================================
-- AUTOSTART
-- ============================================

hl.exec_cmd("if pgrep waybar > /dev/null; then pkill waybar; fi && waybar")

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")
    hl.exec_cmd("swaybg -m fill -i ~/.dotfiles/resources/wallpaper/wallpaper5.jpg")
    hl.exec_cmd("nwg-drawer -r")
    hl.exec_cmd("swaync")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("waybar")
    hl.exec_cmd("1password --silent")
    hl.exec_cmd("wl-paste -t text --watch cliphist store &")
    hl.exec_cmd("[ -x \"$(command -v wl-paste)\" ] && [ -x \"$(command -v cliphist)\" ] && wl-paste --watch cliphist store &")
    hl.exec_cmd("[ -x \"$(command -v wl-paste)\" ] && [ -x \"$(command -v cliphist)\" ] && wl-paste --watch pkill -RTMIN+9 waybar &")
    hl.exec_cmd("/usr/bin/pypr")
    hl.exec_cmd("hypridle")
end)
