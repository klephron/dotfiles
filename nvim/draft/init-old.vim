"-----------------------------------Plugins------------------------------------------"

call plug#begin(stdpath('data'))

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
" Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ervandew/supertab'
"

"-----------------------------File Formatting, Tabindents---------------------------"

" au BufNewFile,BufRead *.py,*.java,*.cpp,*.c,*.cs,*.rkt,*.h,*.html
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=120 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix |

set modeline

"------------------------------------GUI--------------------------------------------"

set ttimeoutlen=10 "Понижаем задержку ввода escape последовательностей

set statusline+=%F
set laststatus=2
" set showtabline=2

set shortmess+=c
set omnifunc=syntaxcomplete#Complete


set pastetoggle=<F2> " enable paste mode

set visualbell
