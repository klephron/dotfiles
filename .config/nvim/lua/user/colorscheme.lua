local colorscheme = "darkplus"
-- local colorscheme = "carbonfox"
local color = us.color

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

-- pre-return options
vim.cmd("hi VertSplit gui=NONE")

if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- additional options for colorscheme
vim.cmd("hi clear TSComment")
vim.cmd("hi link TSComment Comment")

vim.cmd("hi clear Cursor")
vim.cmd("hi Cursor guibg=#cccccc")
vim.cmd("hi clear NonText")
vim.cmd("hi link NonText IndentBlanklineChar")

-- Treesitter
vim.cmd("hi link @namespace StorageClass")

-- highlight background with foreground of cursorline
-- vim.cmd("hi CursorLineNr guibg=" .. color({"CursorLine", "bg"}) .. " guifg=" .. color({"CursorLineNr", "fg"}))

-- vim.cmd("hi TabLine guibg='#252525'")
-- vim.cmd("hi TabLineSel guibg='#252525'")
