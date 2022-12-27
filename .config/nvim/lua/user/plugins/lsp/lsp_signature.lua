local M = {}

function M.setup()
  require("lsp_signature").setup {
    bind = true,
    hint_enable = false,
    floating_window = false,
    auto_close_after = 0,
    transparency = nil,
    toggle_key = require('user.keymaps').lsp.signature_help_i.key, -- toggle signature on and off in insert mode
    select_signature_key = nil, -- cycle to next signature
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
  }
end

return M
