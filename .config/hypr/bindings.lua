-- ============================================
-- KEYBINDINGS
-- ============================================

local mainMod = "SUPER"

-- Mouse binds for window move/resize (bindm)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Event listeners (bindl)
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd"systemctl suspend")

-- Main keybindings
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

-- Switch to a submap called `close`.
hl.bind("CONTROL + S", hl.dsp.submap("close"))
-- Start a submap called "close".
hl.define_submap("close", function()
    hl.bind("Q", function()
        hl.dispatch(hl.dsp.window.close())
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("R", function()
        hl.dsp.exec_cmd("~/.bin/hypr_monitors")
        hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind("CONTROL + ALT + L", hl.dsp.exec_cmd("~/.config/hypr/lock.sh"))
hl.bind("CONTROL + ALT + BACKSPACE", hl.dsp.exec_cmd("wlogout --protocol layer-shell"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("pcmanfm"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wofi"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pypr fetch_client_menu"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("alacritty --class 1pass,1pass -e $HOME/.config/tmux/plugins/tmux-1password/scripts/main.sh"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("alacritty --class 1pass,1pass -e $HOME/.config/tmux/plugins/tmux-1password/scripts/mps.sh"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("ALT + V", hl.dsp.exec_cmd("cliphist list | wofi -dmenu | cliphist decode | wl-copy"))
-- hl.bind("ALT + TAB", hl.dsp.workspace("previous"))
-- hl.bind("", "XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.bin/sway_volume --inc"))
-- hl.bind("", "XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.bin/sway_volume --dec"))
-- hl.bind("", "XF86AudioMicMute", hl.dsp.exec_cmd("~/.bin/sway_volume --toggle-mic"))
-- hl.bind("", "XF86AudioMute", hl.dsp.exec_cmd("~/.bin/sway_volume --toggle"))
-- hl.bind("", "XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.bin/brightness.sh --dec"))
-- hl.bind("", "XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.bin/brightness.sh --inc"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("ALT + up", hl.dsp.exec_cmd("~/.bin/sway_volume --inc"))
hl.bind("ALT + down", hl.dsp.exec_cmd("~/.bin/sway_volume --dec"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + Z", hl.dsp.window.fullscreen({mode="fullscreen"}))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.fullscreen({mode="maximized"}))
-- hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.fullscreen_state(-1, 1))

hl.bind(mainMod .. " + CONTROL + S", function()
    hl.dispatch(hl.dsp.exec_cmd("slack"))
    hl.dispatch(hl.dsp.exec_cmd("thunderbird"))
    hl.dispatch(hl.dsp.exec_cmd("/opt/teams-for-linux/teams-for-linux"))
    hl.dispatch(hl.dsp.exec_cmd("alacritty --class mps_vpn -e ~/.bin/mps_connect.sh"))
end)

-- NOTE: Original config had multiple bindings with same key (Q and A in submap)
-- This creates conflicts. Kept all for compatibility but user should review

-- Focus movement
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10 (optimized loop)
for i = 1, 10 do
    hl.bind(mainMod .. " + " .. (i == 10 and "0" or tostring(i)), hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. (i == 10 and "0" or tostring(i)), hl.dsp.window.move({ workspace = i }))
end

-- Window swaps
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({direction = "right"}))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({direction = "left"}))

-- Mouse navigation
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace("e+1"))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace("e-1"))

-- Screenshot bindings
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd('grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png'))


-- Clipboard direct access
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("cliphist list | wofi -dmenu | cliphist decode | wl-copy"))

-- Power menu
hl.bind(mainMod .. " + DELETE", hl.dsp.exec_cmd("wlogout --protocol layer-shell"))

-- App launcher aliases
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("alacritty"))


local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
