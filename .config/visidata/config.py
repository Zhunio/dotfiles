# Catppuccin mocha colors
colors = {
    'rosewater': '#f5e0dc',
    'flamingo': '#f2cdcd',
    'pink': '#f5c2e7',
    'mauve': '#cba6f7',
    'red': '#f38ba8',
    'maroon': '#eba0ac',
    'peach': '#fab387',
    'yellow': '#f9e2af',
    'green': '#a6e3a1',
    'teal': '#94e2d5',
    'sky': '#89dceb',
    'sapphire': '#74c7ec',
    'blue': '#89b4fa',
    'lavender': '#b4befe',
    'text': '#cdd6f4',
    'subtext1': '#bac2de',
    'subtext0': '#a6adc8',
    'overlay2': '#9399b2',
    'overlay1': '#7f849c',
    'overlay0': '#6c7086',
    'surface2': '#585b70',
    'surface1': '#45475a',
    'surface0': '#313244',
    'base': '#1e1e2e',
    'mantle': '#181825',
    'crust': '#11111b',
    'custom_bg': '#011627',
}

# Background color
options.color_default = f"{colors['text']} on {colors['custom_bg']}"
options.color_column_sep = f"{colors['overlay2']} on {colors['custom_bg']}"

# Top row: database columns (option var names)
options.color_default_hdr = f"bold {colors['text']} on {colors['blue']}"
options.color_bottom_hdr = f"underline {colors['sky']} on {colors['custom_bg']}"
options.color_current_hdr = f"bold {colors['custom_bg']} on {colors['teal']}"

# Sidebar: status messages based on actions (option var names)
options.color_sidebar = f"{colors['text']} on {colors['surface0']}"
options.color_sidebar_title = f"bold {colors['custom_bg']} on {colors['yellow']}"
options.color_status = f"bold {colors['text']} on {colors['base']}"
options.color_error = f"bold {colors['custom_bg']} on {colors['red']}"
options.color_warning = f"bold {colors['custom_bg']} on {colors['peach']}"

# Bottom row: sheet/status/rows/highlights (option var names)
options.color_top_status = f"underline {colors['sky']} on {colors['mantle']}"
options.color_active_status = f"bold {colors['custom_bg']} on {colors['blue']}"
options.color_inactive_status = f"{colors['overlay2']} on {colors['mantle']}"
options.color_highlight_status = f"bold {colors['custom_bg']} on {colors['green']}"

# Highlighted column and row
options.color_current_row = 'reverse'
options.color_current_col = f"bold {colors['text']} on {colors['surface1']}"
options.color_current_cell = f"bold {colors['custom_bg']} on {colors['teal']}"

# Header menu: File/Edit/View/Column/Row/Data/Plot (option var names)
options.color_menu = f"{colors['text']} on {colors['base']}"
options.color_menu_active = f"bold {colors['custom_bg']} on {colors['blue']}"
options.color_menu_spec = f"{colors['sky']} on {colors['base']}"
options.color_menu_help = f"{colors['yellow']} on {colors['base']}"
