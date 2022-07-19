set nocompatible

" gvim "{{{
" -----------------------------------------------------------------------------
set guifont=MesloLGS\ Nerd\ Font\ Mono\ 11
set guioptions=0 "disable scroll in GUI
set showtabline=0 "disalbe tab panel (FTW window)
"}}}


" Options "{{{
" -----------------------------------------------------------------------------
"set fileencodings=utf-8,sjis,euc-jp,latin
set fileencodings=utf-8
set encoding=utf-8
"" set langmenu=en_US.UTF-8
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

set noshowmode
set shortmess+=c
set showcmd
set wildmenu "graphical auto complete menu

"}}}


" Movement "{{{
" -----------------------------------------------------------------------------
set scrolloff=8
" set mouse to normal and visual mode
set mouse=nv

"}}}


" Searching "{{{
" -----------------------------------------------------------------------------
set noshowmatch
set incsearch "search as characters are entered
set hlsearch "highlights matching searches
" ignore case when searching
set ignorecase
" finding files - search down into subfolders
set path+=**
"" set wildignore+=*/node_modules/*

"}}}


" Highlights "{{{
" -----------------------------------------------------------------------------
set cursorline

"}}}


" Syntax, theme"{{{
" -----------------------------------------------------------------------------
syntax enable 
set background=dark
colorscheme base16-nord_custom
" colorscheme default
" File types, Groups "{{{
" -----------------------------------------------------------------------------
filetype plugin indent on

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


" Editing "{{{
" -----------------------------------------------------------------------------
set autoindent
set smartindent
" use spaces to insert tab
set expandtab
" use shiftwidth and tabstop
set smarttab
set tabstop=2
set softtabstop=2
" used with >> and <<
set shiftwidth=2
" when a bracket is inserted, NOT briefly jump to the matching one
set backspace=start,eol,indent
"}}}


" vim: set foldmethod=marker foldlevel=0:

