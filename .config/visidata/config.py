# Use terminal default fg/bg so VisiData matches your terminal background.
options.color_default = ''
options.color_default_hdr = 'bold'
options.color_bottom_hdr = 'underline'
options.color_column_sep = ''
options.color_menu = ''
options.color_menu_active = 'bold'
options.color_menu_spec = ''
options.color_menu_help = ''
options.color_status = 'bold'
options.color_top_status = ''
options.color_active_status = ''
options.color_inactive_status = ''
options.color_highlight_status = 'bold'
options.color_keystrokes = 'bold'

# tmux uses Ctrl+S as prefix; use zS in VisiData to save current sheet
BaseSheet.bindkey('zS', 'save-sheet')

# Use the system clipboard for all copy commands and cell paste.
Sheet.bindkey('y', 'syscopy-row')  # Copy current row.
Sheet.bindkey('gy', 'syscopy-selected')  # Copy selected rows.
Sheet.bindkey('zy', 'syscopy-cell')  # Copy current cell.
Sheet.bindkey('gzy', 'syscopy-cells')  # Copy current column's cells in selected rows.
Sheet.bindkey('zp', 'syspaste-cells')  # Paste starting at current cell; may span rows/columns.
Sheet.bindkey('gzp', 'syspaste-cells-selected')  # Paste into selected rows, starting at current column.
