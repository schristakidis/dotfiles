-- ============================================
-- GENERAL SETTINGS
-- ============================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgb(cdd6f4)",
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 5,
    },

    misc = {
        disable_hyprland_logo = true,
    },

    dwindle = {
        preserve_split = true,
        force_split = 2,
    },

    master = {
        new_status = "master",
    },

    input = {
        kb_layout = "us,gr",
        kb_variant = "",
        kb_model = "",
        kb_rules = "",
        follow_mouse = 1,

        touchpad = {
            natural_scroll = false,
            disable_while_typing = true,
        },

        sensitivity = 0,
    },

    -- gestures = {
    --     workspace_swipe = false,
    -- },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
    },
})
