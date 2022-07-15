local fn = vim.fn
-----------------------------------------------------------------------------//
-- Message output on vim actions
-----------------------------------------------------------------------------//
vim.opt.shortmess:append("c")
-----------------------------------------------------------------------------//
-- Format Options
-----------------------------------------------------------------------------//
-- vim.opt.formatoptions = { }
-----------------------------------------------------------------------------//
-- Timings
-----------------------------------------------------------------------------//
vim.opt.updatetime = 4000
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 50
-----------------------------------------------------------------------------//
-- Window splitting and buffers
-----------------------------------------------------------------------------//
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.eadirection = "both"
vim.opt.hidden = true -- allow hide a buffer

vim.opt.switchbuf = 'useopen,uselast'
-- Characters to fill the statuslines and vertical separators
-- vim.opt.fillchars = { }
-- vim.opt.fillchars.eob=" "
-----------------------------------------------------------------------------//
-- Fileformat and encoding
-----------------------------------------------------------------------------//
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileformat = "unix"
-----------------------------------------------------------------------------//
-- Backups and swaps
-----------------------------------------------------------------------------//
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.swapfile = false
-----------------------------------------------------------------------------//
-- Display
-----------------------------------------------------------------------------//
vim.opt.termguicolors = true
vim.opt.background ="dark"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
--vim.opt.rnu = true
vim.opt.cmdheight = 1
vim.opt.showcmd = false
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.conceallevel = 2
vim.opt.pumheight = 15
vim.opt.signcolumn = 'auto:1-3'

-- vim.opt.emoji = false
-----------------------------------------------------------------------------//
-- Cursor
-----------------------------------------------------------------------------//
-- vim.opt.guicursor = {
--   [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
--   [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
--   [[sm:block-blinkwait175-blinkoff150-blinkon175]],
-- }
vim.opt.cursorlineopt = 'screenline,number'
-----------------------------------------------------------------------------//
-- Title
-----------------------------------------------------------------------------//
vim.opt.title = true
vim.opt.titlelen = 85
-- vim.opt.titlestring = ""
-- vim.opt.titleold = ""
----------------------------------------------------------------------------//
-- Wrapping
-----------------------------------------------------------------------------//
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.whichwrap:prepend("<,>,[,]")
----------------------------------------------------------------------------//
-- Match and search
-----------------------------------------------------------------------------//
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 2

vim.opt.showmatch = false
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
----------------------------------------------------------------------------//
-- Indentation
-----------------------------------------------------------------------------//
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
----------------------------------------------------------------------------//
-- Mouse
-----------------------------------------------------------------------------//
vim.opt.mouse = "nv"
vim.opt.mousefocus = false
----------------------------------------------------------------------------//
-- System specific
-----------------------------------------------------------------------------//
vim.opt.clipboard = "unnamedplus"
----------------------------------------------------------------------------//
-- Utilities
-----------------------------------------------------------------------------//
vim.opt.autowriteall = true -- automatically :write before running commands and changing files
vim.opt.gdefault = true     -- /g in replace is enabled by default (reversed)
vim.opt.confirm = true      -- make vim prompt me to save before doing destructive things
vim.opt.virtualedit = 'block' -- allow cursor to move where there is no text in visual block mode

--vim.g.did_load_filetypes = 0 -- deactivate vim based filetype detection
