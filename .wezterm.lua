local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Platform detection
local is_mac = wezterm.target_triple:find("apple%-darwin") ~= nil

-- Enable or disable Wayland (for KDE Wayland you may want to experiment)
config.enable_wayland = true -- set false if key events are not being registered properly

-- Appearance

-- Font + general
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13.0
config.line_height = 1.2
config.color_scheme = "Catppuccin Mocha"

-- Window frame / decorations
config.window_decorations = "TITLE | RESIZE"
config.window_frame = {
	active_titlebar_bg = "#1f1f28",
	inactive_titlebar_bg = "#2a2a37",
	active_titlebar_fg = "#c0caf5",
	inactive_titlebar_fg = "#646880",
	button_fg = "#c0caf5",
	button_bg = "#1f1f28",
	button_hover_fg = "#ffffff",
	button_hover_bg = "#3a3a55",
}
config.colors = {
	cursor_bg = "#7AA2F7",
	cursor_border = "#7AA2F7",
}

-- Background & opacity / blur
config.window_background_opacity = 0.8 -- slightly translucent
-- On macOS, you can enable blur
if is_mac then
	config.macos_window_background_blur = 20
end
-- On KDE Wayland, if using nightly with blur support
config.kde_window_background_blur = true
-- Enable kitty graphics to show images of fastfetch
config.enable_kitty_graphics = true

-- Inactive panes style (dim unused panes)
config.inactive_pane_hsb = {
	saturation = 0.80,
	brightness = 0.70,
}

-- Tabs
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Padding
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}

-- Clipboard behavior etc
config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "BlinkingBar"

-- Keybindings: cross‑platform versions
config.keys = {
	-- Close current pane
	{
		key = "w",
		mods = "CTRL",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "w",
		mods = "CMD", -- macOS command
		action = act.CloseCurrentPane({ confirm = false }),
	},
	-- Split vertical pane
	{
		key = "v",
		mods = "CTRL",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "CMD",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Split horizontal pane
	{
		key = "h",
		mods = "CTRL",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CMD",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- New tab
	{
		key = "t",
		mods = "CTRL",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "t",
		mods = "CMD",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	-- Toggle full screen
	{
		key = "f",
		mods = "CTRL",
		action = act.ToggleFullScreen,
	},
	{
		key = "f",
		mods = "CMD",
		action = act.ToggleFullScreen,
	},
	-- Copy / Paste
	{
		key = "c",
		mods = "CMD",
		action = act.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CMD",
		action = act.PasteFrom("Clipboard"),
	},
	-- Pane navigation: move focus between panes
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
}

return config
