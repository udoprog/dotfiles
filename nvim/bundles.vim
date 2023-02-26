set nocompatible
filetype off

if &compatible
  set nocompatible
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'bling/vim-airline'
Plug 'godlygeek/tabular'
Plug 'jceb/vim-orgmode'
Plug 'kien/rainbow_parentheses.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tomasr/molokai'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'plasticboy/vim-markdown'
Plug 'reproto/reproto-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()
