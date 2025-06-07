-- Pull in the wezterm API
local wezterm = require("wezterm")

-- window and background
local config = wezterm.config_builder()
config.default_prog = { "pwsh" }
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 10
config.color_scheme = "catppuccin-mocha"
config.font = wezterm.font("JetBrainsMonoNL Nerd Font", { weight = "DemiBold" })
config.window_background_opacity = 0.95
config.inactive_pane_hsb = {
	saturation = 1,
	brightness = 0.7,
}

-- Tab
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Define Catppuccin Mocha palette
local mocha = {
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",

	text = "#cdd6f4",
	subtext0 = "#a6adc8",
	subtext1 = "#bac2de",

	surface0 = "#313244",
	surface1 = "#45475a",
	surface2 = "#585b70",

	overlay0 = "#6c7086",
	overlay1 = "#7f849c",
	overlay2 = "#9399b2",

	blue = "#89b4fa",
	red = "#f38ba8",
	green = "#a6e3a1",
	yellow = "#f9e2af",
}

-- Tab bar color customization
config.colors = {
	tab_bar = {
		background = mocha.crust,

		active_tab = {
			bg_color = mocha.blue,
			fg_color = mocha.crust,
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = mocha.surface0,
			fg_color = mocha.subtext1,
		},
		inactive_tab_hover = {
			bg_color = mocha.surface1,
			fg_color = mocha.text,
		},
		new_tab = {
			bg_color = mocha.crust,
			fg_color = mocha.blue,
		},
		new_tab_hover = {
			bg_color = mocha.crust,
			fg_color = mocha.red,
		},
	},
}

-- Powerline-style arrows
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return string.format("%d %s", tab_info.tab_index + 1, title)
	end
	return string.format("%d %s", tab_info.tab_index + 1, tab_info.active_pane.title)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = mocha.crust
	local background = mocha.surface0
	local foreground = mocha.subtext1

	if tab.is_active then
		background = mocha.blue
		foreground = mocha.crust
	elseif hover then
		background = mocha.surface1
		foreground = mocha.text
	end

	local edge_foreground = background
	local title = tab_title(tab)
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
	-- { key = "[", mods = "LEADER", action = wezterm.action.},
	{
		key = ",",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Rename tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "r",
		mods = "CTRL",
		action = wezterm.action.ReloadConfiguration,
	},

	{ key = "h", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },

	{ key = "H", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "L", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "K", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "J", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- tab
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},

	{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },
	{ key = "0", mods = "LEADER", action = wezterm.action.ActivateTab(9) },

	{
		key = "[",
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "]",
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTabRelative(1),
	},
}
-- move tab to direction
for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

config.use_dead_keys = false

-- Use "vi" style keybindings in copy mode
config.enable_kitty_keyboard = true
config.use_ime = true
config.mouse_bindings = {
	-- Enable selecting text in copy mode
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action({ SelectTextAtMouseCursor = "Cell" }),
	},
}

-- Return final config
return config
