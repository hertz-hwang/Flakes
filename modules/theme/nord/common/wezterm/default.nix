{ config, pkgs, ... }:

{
  programs = {
    wezterm = {
      extraConfig = ''
          local function font_with_fallback(name, params)
        	local names = { name, "Noto Color Emoji" }
        	return wezterm.font_with_fallback(names, params)
        end
          local font_name = "FiraCode Nerd Font"
          return {
              -- OpenGL for GPU acceleration, Software for CPU
              front_end = "OpenGL",

              -- Font config
              font = font_with_fallback(font_name),
              font_rules = {
              	{
              		italic = true,
              		font = font_with_fallback(font_name, { italic = false }),
              	},
              	{
              		italic = true,
              		intensity = "Bold",
              		font = font_with_fallback(font_name, { italic = false, bold = true }),
              	},
              	{
              		intensity = "Bold",
              		font = font_with_fallback(font_name, { bold = true }),
              	},
              },
              warn_about_missing_glyphs = false,
              font_size = 13,
              line_height = 1.0,

              -- Cursor style
              default_cursor_style = "BlinkingUnderline",

              -- X11
              enable_wayland = true,

              -- Keybinds
              disable_default_key_bindings = true,
              keys = {
              	{
              		key = [[\]],
              		mods = "CTRL|ALT",
              		action = wezterm.action({
              			SplitHorizontal = { domain = "CurrentPaneDomain" },
              		}),
              	},
              	{
              		key = [[\]],
              		mods = "CTRL",
              		action = wezterm.action({
              			SplitVertical = { domain = "CurrentPaneDomain" },
              		}),
              	},
              	{
              		key = "q",
              		mods = "CTRL",
              		action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
              	},
              	{
              		key = "h",
              		mods = "CTRL|SHIFT",
              		action = wezterm.action({ ActivatePaneDirection = "Left" }),
              	},
              	{
              		key = "l",
              		mods = "CTRL|SHIFT",
              		action = wezterm.action({ ActivatePaneDirection = "Right" }),
              	},
              	{
              		key = "k",
              		mods = "CTRL|SHIFT",
              		action = wezterm.action({ ActivatePaneDirection = "Up" }),
              	},
              	{
              		key = "j",
              		mods = "CTRL|SHIFT",
              		action = wezterm.action({ ActivatePaneDirection = "Down" }),
              	},
              	{
              		key = "h",
              		mods = "CTRL|SHIFT|ALT",
              		action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
              	},
              	{
              		key = "l",
              		mods = "CTRL|SHIFT|ALT",
              		action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
              	},
              	{
              		key = "k",
              		mods = "CTRL|SHIFT|ALT",
              		action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
              	},
              	{
              		key = "j",
              		mods = "CTRL|SHIFT|ALT",
              		action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
              	},
              	{ -- browser-like bindings for tabbing
              		key = "t",
              		mods = "CTRL",
              		action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
              	},
              	{
              		key = "w",
              		mods = "CTRL",
              		action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
              	},
              	{
              		key = "Tab",
              		mods = "CTRL",
              		action = wezterm.action({ ActivateTabRelative = 1 }),
              	},
              	{
              		key = "Tab",
              		mods = "CTRL|SHIFT",
              		action = wezterm.action({ ActivateTabRelative = -1 }),
              	}, -- standard copy/paste bindings
              	{
              		key = "x",
              		mods = "CTRL",
              		action = "ActivateCopyMode",
              	},
              	{
              		key = "v",
              		mods = "CTRL|SHIFT",
              		action = wezterm.action({ PasteFrom = "Clipboard" }),
              	},
              	{
              		key = "c",
              		mods = "CTRL|SHIFT",
              		action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
              	},
              },

              -- Aesthetic Night Colorscheme
              bold_brightens_ansi_colors = true,
              colors = {
              	foreground = "#d8dee9",
              	background = "#2e3440",
              	cursor_bg = "#eceff4",
              	cursor_fg = "#282828",
              	cursor_border = "#eceff4",
              	selection_fg = "#4c566a",
              	selection_bg = "#eceff4",
              	scrollbar_thumb = "#edeff0",
              	split = "#2c2e2f",
              	ansi = { "#3b4252","#bf616a","#a3be8c","#ebcb8b","#81a1c1","#b48ead","#88c0d0","#e5e9f0" },
              	brights = { "#2c2e2f", "#e8646a", "#81c19b", "#e79881", "#709ad2", "#c58cec", "#70b8ca", "#f2f4f5" },
              	indexed = { [136] = "#edeff0" },
              	tab_bar = {
              		active_tab = {
              			bg_color = "#4c566a",
              			fg_color = "#eceff4",
              			-- italic = true,
              		},
              		inactive_tab = { bg_color = "#2e3440", fg_color = "#d8dee9" },
              		inactive_tab_hover = { bg_color = "#2e3440", fg_color = "#d8dee9" },
              		new_tab = { bg_color = "#5e81ac", fg_color = "#2e3440" },
              		new_tab_hover = { bg_color = "#5e81ac", fg_color = "#2e3440" },
              	},
              },

              -- Padding
              window_padding = {
              	left = 25,
              	right = 25,
              	top = 25,
              	bottom = 25,
              },

              -- Tab Bar
              enable_tab_bar = true,
              hide_tab_bar_if_only_one_tab = true,
              show_tab_index_in_tab_bar = false,
              tab_bar_at_bottom = true,

              -- General
              automatically_reload_config = true,
              inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
              window_background_opacity = 0.9,
              window_close_confirmation = "NeverPrompt",
              window_frame = { active_titlebar_bg = "#090909", font = font_with_fallback(font_name, { bold = true }) },
                }
      '';
    };
  };
}
