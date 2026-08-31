-- Keybindings
-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mainMod     = "SUPER" -- Sets "Windows" key as main modifier

-- Programs (defined here; loaded together with keybinds)
local terminal    = "foot"
local fileManager = "nemo"
local menu        = "qs -c lancher"
local browser     = "firefox"

-- Launch programs
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd(terminal .. ' -e sh -c "tmux a || tmux"'))
hl.bind("SUPER + ALT + RETURN", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd(browser .. " --private-window"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("ben10"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.pin())
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle

-- Resize windows with mainMod + ALT + arrow keys
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = 50, y = 0 }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = -50 }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = 50 }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 50, y = 0 }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = -50 }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = 50 }))

-- Lock screen and recording
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("~/.local/bin/rec.sh"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("~/.local/bin/Rrec.sh"))

-- Toggle pypr scratchpads
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("pypr-client toggle protonvpn"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("pypr-client toggle foot-dropterm"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pypr-client toggle foot-btop"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("pypr-client toggle foot-nvtop"))

hl.bind("F11", hl.dsp.window.fullscreen())

-- Move focus with mainMod + hjkl / arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("hyprshot -m region"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + TAB", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Misc
hl.bind("XF86Presentation", hl.dsp.exec_cmd("~/notify.clock"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
-- hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
-- hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
