local fn = vim.fn
-----------------------------------------------------------------------------//
-- Message output on vim actions
-----------------------------------------------------------------------------//
vim.opt.shortmess = {
  f = true,
  i = true,
  l = true,
  m = true,
  n = true,
  r = true,
  w = true,
  x = true,
  a = false, -- all above
  o = true,
  O = true,
  s = true,
  t = true,
  T = true,
  W = true,
  A = true,
  I = false,
  c = true,
  q = false,
  F = true,
  S = false,
}
-----------------------------------------------------------------------------//
-- Format Options
-----------------------------------------------------------------------------//
vim.opt.formatoptions = {
  t = false,
  c = true,
  r = true,
  o = false,
  n = true,
  j = true,
  ['1'] = true,
  ['2'] = true, -- Use indent from 2nd line of a paragraph
  -- Only break if the line was not longer than 'textwidth' when the insert
  -- started and only at a white character that has been entered during the
  -- current insert command.
  l = true,
  v = true,
}
-----------------------------------------------------------------------------//
-- Timings
-----------------------------------------------------------------------------//
vim.opt.updatetime = 1000
vim.opt.timeout = true
vim.opt.timeoutlen = 400
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
-- Session
-----------------------------------------------------------------------------//
---
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-----------------------------------------------------------------------------//
-- Display
-----------------------------------------------------------------------------//
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
if fn.has("nvim-0.8") ~= 0 then
  vim.opt.cmdheight = 0

  -- make all keymaps silent by default
  local keymap_set = vim.keymap.set
  vim.keymap.set = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    return keymap_set(mode, lhs, rhs, opts)
  end
else
  vim.opt.cmdheight = 1
end
vim.opt.showcmd = true
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.conceallevel = 0
vim.opt.pumheight = 15
vim.opt.signcolumn = 'yes:1'
-- vim.opt.signcolumn = 'number'

-- vim.opt.emoji = false
-----------------------------------------------------------------------------//
-- Cursor
-----------------------------------------------------------------------------//
vim.opt.guicursor = {
  [[n-v:block,i-ci-ve-c:ver25,r-cr:hor20,o:hor50]],
  [[a:Cursor/lCursor]],
  -- [[a:blinkwait700-blinkoff400-blinkon250]],
  -- [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}
vim.opt.cursorlineopt = 'screenline,number'
-----------------------------------------------------------------------------//
-- Title
-----------------------------------------------------------------------------//
vim.opt.title = true
vim.opt.titlelen = 85
vim.opt.titlestring = [[NVIM (%{tabpagenr()} of %{tabpagenr('$')}) %{substitute(getcwd(),$HOME,'~','')}]]
-- vim.opt.titleold = ""
----------------------------------------------------------------------------//
-- Wrapping
-----------------------------------------------------------------------------//
vim.opt.wrap = true
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
vim.opt.mouse = "nvc"
vim.opt.mousefocus = false
----------------------------------------------------------------------------//
-- System specific
-----------------------------------------------------------------------------//
vim.opt.clipboard = "unnamedplus"
----------------------------------------------------------------------------//
-- Utilities
-----------------------------------------------------------------------------//
vim.opt.autowriteall = true -- automatically :write before running commands and changing files
vim.opt.gdefault = true -- /g in replace is enabled by default (reversed)
vim.opt.confirm = false -- make vim prompt me to save before doing destructive things
vim.opt.virtualedit = 'block' -- allow cursor to move where there is no text in visual block mode

--vim.g.did_load_filetypes = 0 -- deactivate vim based filetype detection
-----------------------------------------------------------------------------//
-- KEYS
-----------------------------------------------------------------------------//
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-----------------------------------------------------------------------------//
-- Folding
-----------------------------------------------------------------------------//
-- vim.opt.foldlevelstart = 2
vim.opt.foldmethod = 'marker'
vim.opt.foldlevel = 0
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
-----------------------------------------------------------------------------//
-- Listchars
-----------------------------------------------------------------------------//
vim.opt.list = false
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append "space:⋅"
-----------------------------------------------------------------------------//
-- Recommended-style
-----------------------------------------------------------------------------//
vim.g.rust_recommended_style = 0
