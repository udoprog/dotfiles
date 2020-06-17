" vim: sw=2 foldmethod=marker

" {{{ Bundles
source ~/.config/nvim/bundles.vim
""" }}}

" {{{ Basic Settings
syntax enable
filetype plugin on
filetype indent on

silent! colorscheme molokai

set t_Co=256
set sw=4
set tabstop=4
set number
set expandtab
set modelines=5
set novisualbell
set t_vb=
set updatetime=1000
set laststatus=2
set history=1000
set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set cursorline
set dictionary=/usr/share/dict/words
set encoding=utf-8
set fillchars=diff:⣿,vert:│
set gdefault
set hidden
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set linebreak
set list
set listchars=tab:▸\ ,trail:¬,extends:❯,precedes:❮
set matchtime=3
set modeline
set ruler
set scrolloff=3
set shiftround
set showbreak=↪
set showcmd
set showmatch
set showmode
set smartcase
set splitbelow
set splitright
set title
set ttyfast
set wildmenu
set wildmode=list:longest
" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800
" Time out on key codes but not mappings
set notimeout
set ttimeout
set ttimeoutlen=1
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"
" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
"Make line wrapping act sanely
set wrap
set textwidth=99
set formatoptions=qrn1
set colorcolumn=100

set wildignore+=**/.svn
set wildignore+=*.class
set wildignore+=**/tmp

set spell spelllang=en_us
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/dictionary.add

let mapleader = ","
let maplocalleader = '\'

if exists('+colorcolumn')
  set colorcolumn=+1
endif

if exists('+undofile')
  set undofile
  set undoreload=10000
endif

if exists('+relativenumber')
  nnoremap <leader>l :set relativenumber!<cr>
else
  nnoremap <leader>l :set number!<cr>
endif

" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * :wincmd =

" Custom Highlights
highlight NonText guifg=#909090
highlight SpecialKey guifg=#909090

" Improved search
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<CR>

" Highlight trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" tab navigation like firefox
nmap <C-h> :tabp<CR>
nmap <C-l> :tabn<CR>
" }}}

" {{{ Plugin Settings
let g:vim_markdown_folding_disabled = 1

let NERDTreeIgnore=['\.o$', '\.pyc$', '\~$']
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" {{{ Airline
let g:airline_powerline_fonts = 1
" }}}

" {{{ Syntastic
if exists("g:loaded_syntastic_plugin")
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_auto_loc_list = 1
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_cpp_compiler = 'g++'
  let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
endif
" }}}

nnoremap <leader>t :GFiles<cr>
nnoremap <leader>r :NERDTreeFind<cr>
map <F3> :NERDTreeToggle<CR>
" }}}

" {{{ FileType Setup
function! SetupJava()
  set path=src/main/java,src/test/java,$JAVA_HOME/src
  set suffixesadd=.java
endfunction

function! SetupPHP()
  set noexpandtab
  set suffixesadd=.php
endfunction

function! SetupPython()
  nmap <leader>d :!pydoc <cfile><CR>
  set suffixesadd=.py
endfunction

function! SetupRuby()
  set tabstop=2
  set shiftwidth=2
  set suffixesadd=.rb
endfunction

function! SetupEPL()
  set filetype=sql
endfunction

function! SetupNGT()
  set tabstop=2
  set shiftwidth=2
  set filetype=html
  set suffixesadd=.ngt
endfunction

function! SetupPOM()
  set tabstop=2
  set shiftwidth=2
  set filetype=xml
  set expandtab
endfunction

function! SetupRust()
  set hidden
  set expandtab
endfunction

function! SetupClojure()
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
endfunction

function! SetupASM()
  set tabstop=4
  set shiftwidth=4
  set noexpandtab
endfunction

function! SetupJavaScript()
  set tabstop=2
  set shiftwidth=2
  set expandtab
endfunction

function! SetupJSX()
  set tabstop=2
  set shiftwidth=2
  set expandtab
  let g:syntastic_javascript_checkers = ['eslint']
endfunction

function! SetupTSX()
  set tabstop=2
  set shiftwidth=2
  set expandtab
  let g:syntastic_javascript_checkers = ['eslint']
endfunction

function! SetupTS()
  set tabstop=2
  set shiftwidth=2
  set expandtab
  let g:syntastic_typescript_checkers = ['eslint']
endfunction

function! SetupTSDefs()
  set tabstop=2
  set shiftwidth=2
  set expandtab
  let g:syntastic_typescript_checkers = ['eslint']
endfunction

if has("autocmd")
  " do all autocmd stuff here
  " autocmd FileType javascript <cmd>
  autocmd BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
  autocmd BufNewFile,BufRead *.java :call SetupJava()
  autocmd BufNewFile,BufRead *.py :call SetupPython()
  autocmd BufNewFile,BufRead *.php :call SetupPHP()
  autocmd BufNewFile,BufRead *.rb :call SetupRuby()
  autocmd BufNewFile,BufRead *.epl :call SetupEPL()
  autocmd BufNewFile,BufRead *.pp set filetype=puppet
  autocmd BufNewFile,BufRead *.ngt :call SetupNGT()
  autocmd BufNewFile,BufRead *.rs :call SetupRust()
  autocmd BufNewFile,BufRead *.clj :call SetupClojure()
  autocmd BufNewFile,BufRead *.s :call SetupASM()
  autocmd BufNewFile,BufRead *.S :call SetupASM()
  autocmd BufNewFile,BufRead *.js :call SetupJavaScript()
  autocmd BufNewFile,BufRead *.jsx :call SetupJSX()
  autocmd BufNewFile,BufRead *.tsx :call SetupTSX()
  autocmd BufNewFile,BufRead *.d.ts :call SetupTSDefs()
  autocmd BufNewFile,BufRead *.ts :call SetupTS()
  autocmd BufNewFile,BufRead pom.xml :call SetupPOM()

  " autocmd! BufWritePost *.rs Neomake cargo
endif
" }}}

" {{{ Learn Vim The Hard Way
" Learn vim the hard way.
" Disable movement keys and escape.
noremap <Left> <NOP>
inoremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
inoremap <Up> <NOP>
noremap <Down> <NOP>
inoremap <Down> <NOP>

" Escape remapping to tab.
inoremap jk <Esc>
" }}}

" {{{ source project-specific settings
if filereadable('./.pvimrc')
  source ./.pvimrc
endif

if isdirectory('./include')
  let &path=getcwd() . '/include' . ',' . &path
endif
" }}}

" {{{ cscope
set cscopetag

if filereadable('cscope.out')
  cs add cscope.out
endif
" }}}

" {{{ coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}
