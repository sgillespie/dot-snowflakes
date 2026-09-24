-- Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- [[ Monitors ]]
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- [[ Programs ]]
-- Set programs that you use
local terminal = "ghostty"
local fileManager = "pcmanfm"
local menu = "rofi -show run"

-- [[ Autostart ]]
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- Autostart necessary processes (like notifications daemons, status bars, etc.)
hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
	hl.exec_cmd(
		"waybar -c $HOME/.config/hypr/config.jsonc -s $HOME/.config/hypr/style.css"
	)
	hl.exec_cmd(
		[[sh -c 'source /etc/os-release && exec hyprpaper -c "$HOME/.config/hypr/hyprpaper-$ID.conf"']]
	)
end)

-- [[ Environment Variables ]]
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- [[ Permissions ]]
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-- [[ Look and Feel ]]
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		layout = "dwindle",
		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,
		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		col = {
			active_border = "rgba(C0A36Eff)",
			inactive_border = "rgba(54546Dcc)",
		},
	},

	decoration = {
		rounding = 4,
		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.95,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = false,
		},
	},

	animations = {
		enabled = false,
	},
})

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
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- Triple-buffer when needed
hl.config({
	render = {
		new_render_scheduling = true,
	},
})

-- [[ Misc ]]
hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})

-- [[ Input ]]
hl.config({
	cursor = {
		no_hardware_cursors = 1,
	},

	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "ctrl:swapcaps",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

-- [[ Keybindings ]]
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- [ Basic Launchers ]
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Backspace", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(menu))

-- [ Navigation ]
-- Vim-style navigation
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
-- Arrow navigation
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Manipulating windows
hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" })
)
hl.bind(mainMod .. " + Y", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Manipulating workspaces (Dwindle)
hl.bind(mainMod .. " + Return", hl.dsp.layout("movetoroot active stable"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.layout("movetoroot active unstable"))
hl.bind(mainMod .. " + R", hl.dsp.layout("rotatesplit"))
hl.bind(mainMod .. " + S", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))

-- Manipulating workspaces (Scrolling)
hl.bind(mainMod .. " + C", hl.dsp.layout("colresize 1.0"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.layout("colresize 0.5"))
-- Submap for everything else
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.submap("Tape"))
hl.define_submap("Tape", function()
	-- Scrolling the tape
	hl.bind("H", hl.dsp.layout("focus l"), { repeating = true })
	hl.bind("L", hl.dsp.layout("focus r"), { repeating = true })
	hl.bind("SHIFT + H", hl.dsp.layout("swapcol l"))
	hl.bind("SHIFT + L", hl.dsp.layout("swapcol r"))
	hl.bind("M", hl.dsp.layout("move +col"), { repeating = true })
	hl.bind("SHIFT + M", hl.dsp.layout("move -col"), { repeating = true })
	-- Column width
	hl.bind("E", hl.dsp.layout("fit expand"))
	hl.bind("A", hl.dsp.layout("fit all"))
	hl.bind("V", hl.dsp.layout("fit_into_view"))
	-- Move windows between columns
	hl.bind("P", hl.dsp.layout("promote"))
	hl.bind("N", hl.dsp.layout("consume_or_expel next"))
	hl.bind("B", hl.dsp.layout("consume_or_expel prev"))

	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + Minus", hl.dsp.workspace.toggle_special("0:Magic"))
hl.bind(
	mainMod .. " + SHIFT + Minus",
	hl.dsp.window.move({ workspace = "special:0:Magic" })
)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- [[ Windows and Workspaces ]]
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.workspace_rule({
	workspace = "1",
	default_name = "1:Code",
	persistent = true,
})

hl.workspace_rule({
	workspace = "2",
	default_name = "2:Office",
	persistent = true,
	layout = "scrolling",
})

hl.workspace_rule({
	workspace = "3",
	default_name = "3:Social",
	persistent = true,
})

for i = 4, 10 do
	hl.workspace_rule({
		workspace = tostring(i),
		default_name = i .. ":Extra",
	})
end

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
