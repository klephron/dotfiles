set nocompatible


" Autocmd "{{{
" -----------------------------------------------------------------------------
" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

"}}}


" Options "{{{
" -----------------------------------------------------------------------------
"set fileencodings=utf-8,sjis,euc-jp,latin
set fileencodings=utf-8
set encoding=utf-8
" set backup while while being written
set nobackup
set writebackup
set noswapfile " doesn't create swap files
set shell=zsh
set clipboard=unnamedplus
set fileformat=unix

" open new buffers without saving current modifications (buffer remains open)
set hidden
" providers
let g:loaded_perl_provider = 0
"}}}


" Visual representation "{{{
" -----------------------------------------------------------------------------
" set title of the window
set title
" relative numbering
set nu rnu
set showcmd
set cmdheight=1
set laststatus=2
" Don't redraw while executing macros (good performance config)
set lazyredraw

set textwidth=100
set nowrap

"}}}


" Movement "{{{
" -----------------------------------------------------------------------------
set scrolloff=8
" set mouse to normal and visual mode
set mouse=nv

"}}}


" Searching "{{{
" -----------------------------------------------------------------------------
set hlsearch
" ignore case when searching
set ignorecase
" finding files - search down into subfolders
set path+=**
"" set wildignore+=*/node_modules/*

" incremental substitution (nvim)
if has('nvim')
  set inccommand=split
endif

"}}}


" Highlights "{{{
" -----------------------------------------------------------------------------
set cursorline

"}}}


" Syntax, theme "{{{
" -----------------------------------------------------------------------------
syntax enable 
set background=dark
" true color
if exists("&termguicolors")
  syntax enable
  set termguicolors
  " enable pseudo-transparency for a floating window. 0 - fully opaque, 100 - fully transparent
  "" set winblend=0
  " enable pseudo-transparency for the popup-menu. 0 - fully opaque, 100 - fully transparent
  "" set pumblend=5
  set background=dark

  ""let g:neosolarized_termtrans=1
  runtime ./colors/neo-solarized.vim
  runtime ./colors/base16-nord_custom.vim
  colorscheme base16-nord_custom
endif

"}}}


" File types, Groups "{{{
" -----------------------------------------------------------------------------
au BufRead,BufNewFile *.inc,*.asm set filetype=nasm

augroup Binary
  au!
  au BufReadPre   *.bin,*.exe let &bin=1
  au BufReadPost  *.bin,*.exe if &bin | %!xxd
  au BufReadPost  *.bin,*.exe set ft=xxd | endif
  au BufWritePre  *.bin,*.exe if &bin | %!xxd -r
  au BufWritePre  *.bin,*.exe endif
  au BufWritePost *.bin,*.exe if &bin | %!xxd
  au BufWritePost *.bin,*.exe set nomod | endif
augroup END

augroup Focus
  au BufLeave * silent! wall
augroup END

"}}}


" Imports "{{{
" -----------------------------------------------------------------------------
if has('nvim')
  runtime ./plug.vim
  runtime ./maps.vim
else
  source ~/.config/nvim/plug.vim
  source ~/.config/nvim/maps.vim
endif

"}}}


" Editing "{{{
" -----------------------------------------------------------------------------
filetype plugin indent on
set autoindent
set smartindent
" use spaces to insert tab
set expandtab
" use shiftwidth and tabstop
set smarttab
set tabstop=2
" used with >> and <<
set shiftwidth=2
" when a bracket is inserted, NOT briefly jump to the matching one
set noshowmatch
set backspace=start,eol,indent

"}}}


" vim: set foldmethod=marker foldlevel=0:

