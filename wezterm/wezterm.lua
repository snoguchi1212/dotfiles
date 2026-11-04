local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- general
config.automatically_reload_config = true
config.colors = require("theme")
config.bold_brightens_ansi_colors = "BrightAndBold"

-- env
config.term = "xterm-256color"

-- window
config.window_background_opacity = 0.75
config.macos_window_background_blur = 20
config.window_decorations = "TITLE | RESIZE"
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }
config.window_close_confirmation = "NeverPrompt"
config.enable_tab_bar = false
config.audible_bell = "Disabled"

-- scrolling
config.scrollback_lines = 10000

-- selection
config.selection_word_boundary = "|:\"' {}()[]<>\t\n"

-- font
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14.5
config.line_height = 1.15

-- shell
config.default_prog = { "/bin/bash", "-c", "$HOME/dotfiles/bin/scripts/attach_tmux" }

-- cursor
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 750
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- keyboard
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.disable_default_key_bindings = true
config.keys = {
  { key = "n", mods = "SUPER", action = act.SpawnWindow },
  { key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  { key = "f", mods = "SUPER", action = act.ToggleFullScreen },
  { key = "q", mods = "SUPER", action = act.HideApplication },
  { key = "w", mods = "SUPER", action = act.HideApplication },
  { key = "f", mods = "SUPER|CTRL", action = act.ToggleFullScreen },
  { key = "h", mods = "SUPER", action = act.HideApplication },
  { key = "m", mods = "SUPER", action = act.Hide },
  { key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackAndViewport") },
  { key = "=", mods = "SUPER", action = act.IncreaseFontSize },
  { key = "+", mods = "SUPER", action = act.IncreaseFontSize },
  { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
  { key = "0", mods = "SUPER", action = act.ResetFontSize },
  { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
  { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
}

-- mouse
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },
  {
    event = { Up = { streak = 2, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },
  {
    event = { Up = { streak = 3, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.Nop,
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = "NONE",
    alt_screen = false,
    action = act.ScrollByLine(-10),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = "NONE",
    alt_screen = false,
    action = act.ScrollByLine(10),
  },
}

return config
