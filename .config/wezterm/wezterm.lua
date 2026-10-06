-- WezTerm 跨平台配置（macOS / Linux / Windows 通用）
-- 位置: ~/.config/wezterm/wezterm.lua

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============ 配色：coolnight（与原 Alacritty 一致） ============
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- ============ 字体 ============
config.font = wezterm.font("MesloLGS NF")
config.font_size = 13

-- ============ 窗口 ============
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
-- 无标题栏但可缩放（类似 Alacritty 的 Buttonless）
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8

-- 背景模糊仅 macOS 支持，其他平台安全忽略
if wezterm.target_triple:find("apple") ~= nil then
	config.macos_window_background_blur = 10
end

-- ============ 标签栏 ============
config.enable_tab_bar = false

-- ============ Alt 键行为（对应 Alacritty option_as_alt = 'Both'） ============
-- false = Alt 作为 Meta 修饰键（发送 ESC 前缀），vim/herdr 快捷键需要
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- ============ TERM ============
config.term = "xterm-256color"

return config
