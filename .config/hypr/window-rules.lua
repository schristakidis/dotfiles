-- ============================================
-- WINDOW RULES
-- ============================================

-- Float rules
hl.window_rule({ name = "float-pavucontrol", match = { class = ".*pavucontrol$" }, float = true })
hl.window_rule({ name = "float-blueman-manager", match = { class = "blueman-manager" }, float = true })
hl.window_rule({ name = "float-nm-connection-editor", match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ name = "float-thunar", match = { class = "thunar" }, float = true })
hl.window_rule({ name = "float-btop", match = { title = "^btop$" }, float = true })
hl.window_rule({ name = "float-update-sys", match = { title = "^update-sys$" }, float = true })

-- Workspace rules
hl.window_rule({ name = "workspace-slack", match = { class = "Slack" }, workspace = "10" })
hl.window_rule({ name = "workspace-thunderbird", match = { class = "org.mozilla.Thunderbird" }, workspace = "10" })
hl.window_rule({ name = "thunderbird-calendar", match = { class = "org.mozilla.Thunderbird", initial_title = "Calendar Reminders" }, float = true, size = { "40%", "40%" } })
hl.window_rule({ name = "workspace-mps-vpn", match = { class = "mps_vpn" }, workspace = "9" })
hl.window_rule({ name = "workspace-teams", match = { title = "Microsoft Teams(.*)" }, workspace = "8" })
hl.window_rule({ name = "workspace-teams-for-linux", match = { class = "teams-for-linux" }, workspace = "8" })
hl.window_rule({ name = "tile-teams", match = { title = "Microsoft Teams(.*)" }, tile = true })
hl.window_rule({ name = "floating-cal", match = { class = "floating_cal" }, move = { "100%-20", "0" }, float = true })

-- Opacity rules
hl.window_rule({ name = "opacity-pavu", match = { class = "pavu" }, float = true, opacity = "0.8 0.8" })
hl.window_rule({ name = "opacity-pamixer", match = { class = "pamixer" }, opacity = "0.8 0.8" })
hl.window_rule({ name = "opacity-cal", match = { class = "cal" }, opacity = "0.8 0.8" })
hl.window_rule({ name = "stay-focused-steam", match = { title = "^()$", class = "steam" }, stay_focused = true })

-- 1Password rules
hl.window_rule({ name = "float-1pass", match = { class = "1pass" }, float = true })
hl.window_rule({ name = "opacity-1pass", match = { class = "1pass" }, opacity = "0.6 0.6" })

-- Rofi rules
hl.window_rule({ name = "float-rofi", match = { class = "Rofi" }, float = true })
hl.window_rule({ name = "opacity-rofi", match = { class = "Rofi" }, opacity = "0.8 0.8" })

-- Pmixer rules
hl.window_rule({ name = "pmixer", match = { class = "pmixer" }, move = { "100%-20", "0" }, float = true })
hl.workspace_rule({ workspace = "special:pmixer" })

-- Openconnect rules
hl.window_rule({ name = "float-openconnect", match = { class = "python3", title = "openconnect-sso" }, float = true })
hl.window_rule({ name = "float-save-file", match = { title = "\"Save File\"" }, float = true })

-- Kitty rules
hl.window_rule({ name = "opacity-kitty", match = { class = "^kitty$" }, opacity = "0.8 0.8" })
hl.window_rule({ name = "animation-kitty-update", match = { class = "^kitty$", title = "^update-sys$" }, animation = "popin" })

-- Thunar rules
hl.window_rule({ name = "animation-thunar", match = { class = "^thunar$" }, animation = "popin" })
hl.window_rule({ name = "opacity-thunar", match = { class = "^thunar$" }, opacity = "0.8", "0.8" } )

-- Nautilus rules
hl.window_rule({name = "nautilus", match = { class = "^org.gnome.Nautilus$" }, float = true, size = { "50%", "50%" }, animation = "popin", opacity = "0.8 0.8", center = true })

-- Wofi rules
hl.window_rule({ name = "no-anim-wofi", match = { class = "^wofi$" }, no_anim = true })
hl.window_rule({ name = "opacity-wofi", match = { class = "^wofi$" }, opacity = "0.8 0.6" })

-- Idle inhibit rules
hl.window_rule({ name = "idle-inhibit-firefox", match = { class = "firefox" }, idle_inhibit = "fullscreen" })
hl.window_rule({ name = "idle-inhibit-zen", match = { class = "zen" }, idle_inhibit = "fullscreen" })
hl.window_rule({ name = "idle-inhibit-teams", match = { class = "teams-for-linux" }, idle_inhibit = "fullscreen" })

-- Workspace gap rules
hl.workspace_rule({ workspace = "w[t1]", gaps_out = 1, gaps_in = 0 })
hl.workspace_rule({ workspace = "w[tg1]", gaps_out = 1, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 1, gaps_in = 0 })

-- No gaps rules
hl.window_rule({ name = "no-gaps-tv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
hl.window_rule({ name = "no-gaps-f1", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })

-- Browser idle inhibit when fullscreen
hl.window_rule({ name = "idle-inhibit-firefox-fullscreen", match = { class = "firefox" }, idle_inhibit = "fullscreen" })
hl.window_rule({ name = "idle-inhibit-zen-fullscreen", match = { class = "zen" }, idle_inhibit = "fullscreen" })

-- VLC/media player float and center
hl.window_rule({ name = "float-vlc", match = { class = "^vlc$" }, float = true, center = true })
hl.window_rule({ name = "mpv-float", match = { class = "^mpv$" }, float = true, center = true })

-- Discord/Slack no anim and lower opacity
hl.window_rule({ name = "no-anim-discord", match = { class = "Discord" }, no_anim = true, opacity = "0.9 0.9" })
hl.window_rule({ name = "no-anim-slack", match = { class = "Slack" }, no_anim = true, opacity = "0.9 0.9" })

-- Steam idle inhibit in fullscreen
hl.window_rule({ name = "steam-idle-inhibit", match = { class = "Steam" }, idle_inhibit = "fullscreen" })

-- GTK file dialogs float
hl.window_rule({ name = "float-gtk-dialogs", match = { title = ".*Save.*" }, float = true, center = true })
hl.window_rule({ name = "float-gtk-open", match = { title = ".*Open.*" }, float = true, center = true })

-- Notifications on correct workspace
hl.window_rule({ name = "notification-workspace", match = { class = "notifications" }, workspace = "special:notifications" })

-- System dialogs
hl.window_rule({ name = "float-system-dialogs", match = { title = ".*Warning.*" }, float = true, center = true, stay_focused = true })
