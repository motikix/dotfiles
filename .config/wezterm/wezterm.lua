local wezterm = require('wezterm')

return {
  font = wezterm.font_with_fallback({ 'Juisee Nerd Font', 'Noto Emoji' }),
  font_size = 14,
  harfbuzz_features = {},
  color_scheme = 'Catppuccin Mocha',
  enable_tab_bar = false,
  window_padding = {
    top = 0,
    right = 0,
    bottom = 0,
    left = 0,
  },
}
