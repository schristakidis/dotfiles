-- ============================================
-- ENVIRONMENT VARIABLES
-- From env_var.conf and nvidia.conf
-- ============================================

local function is_nvidia()
    local handle = io.popen("lsmod | grep -i nvidia")
    if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result:find("nvidia", 1, true) then
            return true
        end
    end
    return false
end

if is_nvidia() then
    hl.env("LIBVA_DRIVER_NAME", "nvidia")
    hl.env("GBM_BACKEND", "nvidia-drm")
    hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
    hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
    hl.env("NVD_BACKEND", "direct")
end

hl.env("GTK_THEME", "Yaru-sage-dark")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Yaru-sage-dark")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GDK_SCALE", "1")
hl.env("HYPRLAND_LOG_LEVEL", "0")
hl.env("MOZ_ENABLE_WAYLAND", "1")
-- hl.env("WLR_NO_HARDWARE_SENSORS", "1")
-- hl.env("ELECTRON_DISABLE_GPU", "0")
-- These kill steam
-- hl.env("GTK_IM_MODULE", "wayland")
hl.env("QT_IM_MODULE", "wayland")
hl.env("FREETYPE_PROPERTIES", "truetype:interpreter-version=35")
