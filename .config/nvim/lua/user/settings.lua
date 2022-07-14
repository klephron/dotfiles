local options =  {
  fileencoding = "utf-8",
  encoding = "utf-8",
  fileformat = "unix",
  backup = false,
  writebackup = false,
  swapfile = false,
  hidden = true,

  termguicolors = true,
  background ="dark",
  cursorline = true,
  title = true,
  number = true,
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  -- rnu = true,
  cmdheight = 1,
  showcmd = false,
  laststatus = 3,
  wrap = false,
  showmode = false,
  conceallevel = 2,

  scrolloff = 4,
  sidescrolloff = 6,
  clipboard = "unnamedplus",
  mouse = "nv",

  showmatch = false,
  incsearch = true,
  hlsearch = true,
  ignorecase = true,

  autoindent = true,
  smartindent = true,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")
vim.opt.whichwrap:prepend("<,>,[,]")
--vim.opt.fillchars.eob=" "

vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == 'Darwin' and 'open' or 'xdg-open'

-- vim.g.did_load_filetypes = 0 -- deactivate vim based filetype detection
