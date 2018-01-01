set nocompatible
filetype off

if &compatible
  set nocompatible
endif

set rtp+=~/.dein/repos/github.com/Shougo/dein.vim

if dein#load_state(resolve(expand("~/.dein")))
  call dein#begin(resolve(expand("~/.dein")))

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')

  " language client (e.g. RLS)
  call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'sh install.sh'})

  " basics
  " call dein#add("scrooloose/syntastic")
  call dein#add('neomake/neomake')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})

  call dein#add("bling/vim-airline")
  call dein#add("carlosvillu/coffeScript-VIM-Snippets")
  call dein#add("gmarik/vundle")
  call dein#add("godlygeek/tabular")
  call dein#add("guns/vim-clojure-static")
  call dein#add("jceb/vim-orgmode")
  call dein#add("jonathanfilip/vim-lucius")
  call dein#add("kevinw/pyflakes-vim")
  call dein#add("kien/rainbow_parentheses.vim")
  call dein#add("klen/python-mode")
  call dein#add("mattn/emmet-vim")
  call dein#add("mileszs/ack.vim")
  call dein#add("rodjek/vim-puppet")
  call dein#add("scrooloose/nerdcommenter")
  call dein#add("scrooloose/nerdtree")
  call dein#add("sophacles/vim-bundle-mako")
  call dein#add("tomasr/molokai")
  call dein#add("tosik/neocomplcache")
  call dein#add("tpope/vim-classpath")
  call dein#add("tpope/vim-fireplace")
  call dein#add("tpope/vim-fugitive")
  call dein#add("tpope/vim-pathogen")
  call dein#add("tpope/vim-surround")
  call dein#add("ujihisa/neco-ghc")
  call dein#add("vim-scripts/paredit.vim")
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add("plasticboy/vim-markdown")
  call dein#add('leafgarland/typescript-vim')
  call dein#add('joe-skb7/cscope-maps')
  call dein#add('reproto/reproto-vim')

  " rust
  call dein#add('mckinnsb/rust.vim')
  call dein#add('racer-rust/vim-racer')

  " javascript
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')

  call dein#end()
  call dein#save_state()
endif
