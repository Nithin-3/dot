-- Require modular parts
require("environment")
require("keybinds")

----------------
---- MONITORS ----
----------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})
-- hl.monitor({ output = "HDMI-A-2", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("swaync & hypridle & ozhium-ollium & awww-daemon &")
    hl.exec_cmd("pypr & eww daemon")
    hl.exec_cmd("eww open clock & ~/startup")
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 3,

        col = {
            active_border           = "rgba(019606ff)", -- 1 150 6 1 #019606ff
            inactive_border         = "rgba(595959aa)",
            nogroup_border_active   = "rgba(019606ff)",
            nogroup_border          = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,

        active_opacity   = 1,
        inactive_opacity = 0.75,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = false,
            size     = 10,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },
})

hl.config({
    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("fast", { type = "bezier", points = { {0.2, 0.9}, {0.2, 1} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 1, bezier = "fast", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 1, bezier = "fast", style = "popin 95%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1, bezier = "fast", style = "popin 95%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "fast" })

hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "fast" })

hl.animation({ leaf = "layers", enabled = true, speed = 1, bezier = "fast", style = "fade" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "fast", style = "slidefade" })

hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "fast" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        -- pseudotile = false, -- Master switch for pseudotiling. Enabled via mainMod + P below
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 1,  -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })


----------------------
---- WINDOW RULES ----
----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from all apps. You'll probably like this.
-- hl.window_rule({
--     name  = "suppress-maximize",
--     match = { class = ".*" },
--     suppress_event = "maximize",
-- })

-- hl.window_rule({
--     name  = "move-foot-dropterm",
--     match = { initial_class = "^(foot-dropterm)$" },
--     move  = "center",
-- })

-- hl.window_rule({
--     name  = "godot-new-node",
--     match = { class = "Godot", title = "Create New Node" },
--     size  = "600 600",
--     move  = "410 125",
-- })
-- hl.window_rule({
--     name  = "godot-project-settings",
--     match = { class = "Godot", title = "Project Settings.*" },
--     size  = "600 600",
--     move  = "410 125",
-- })
-- hl.window_rule({
--     name  = "godot-instantiate-child",
--     match = { class = "Godot", title = "Instantiate Child Scene" },
--     size  = "600 600",
--     move  = "410 125",
-- })
-- hl.window_rule({
--     name  = "godot-configure-asset",
--     match = { class = "Godot", title = "Configure Asset Before Installing" },
--     size  = "600 600",
--     move  = "410 125",
-- })
-- Make ben matrix fullscreen (SUPER + B, app-id = ben-<monitor>)
hl.window_rule({
    name  = "ben-matrix-fullscreen",
    match = { class = "^ben-" },
    fullscreen = true,
})

-- hl.window_rule({
--     name  = "godot-fullscreen",
--     match = { class = "Godot", title = ".*Godot Engine" },
--     fullscreen = true,
-- })
