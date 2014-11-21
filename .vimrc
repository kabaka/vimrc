filetype plugin on
filetype indent on
syntax   on

set autoindent

set mouse=a

set background=dark
set t_Co=256

set colorcolumn=80
set tabstop=2
set shiftwidth=2
set expandtab

set nocompatible
set omnifunc=syntaxcomplete#Complete

" Folding is off for now, since it causes huge slowdowns on large
" files/pastes.
"set foldmethod=syntax


let g:colorizer_auto_filetype = 'css,html'
let Tlist_Auto_Open           = 1
let Tlist_Exit_OnlyWindow     = 1

nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F3> :set spell spelllang=en_us<CR>
nnoremap <silent> <F4> :set spell&<CR>
"asetlocal spell spelllang=en_us

" Save files with sudo. (nabbed from https://stackoverflow.com/a/7078429)
cmap w!! w !sudo tee > /dev/null %

"""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'                             " align on delimiters
Plug 'junegunn/rainbow_parentheses.vim'                    " parentheses marking
Plug 'tpope/vim-fugitive'                                  " git integration
Plug 'tpope/vim-endwise'                                   " add `end` in Ruby
Plug 'vim-ruby/vim-ruby'                                   " complete Ruby support
Plug 'tomasr/molokai'                                      " color theme
Plug 'https://kylej@bitbucket.org/ns9tks/vim-autocomplpop' " IDE-like autocompletion
Plug 'sukima/xmledit'                                      " XML/HTML/SGML editing
Plug 'evanmiller/nginx-vim-syntax'                         " nginx config files
Plug 'pangloss/vim-javascript'                             " javascript indentation/highlighting
Plug 'noprompt/vim-yardoc'                                 " syntax highlighting within comments
Plug 'hallison/vim-ruby-sinatra'                           " sinatra syntax highlighting
Plug 'chrisbra/Colorizer'                                  " highlight colors within text
Plug 'chrisbra/csv.vim'                                    " view CSV files as tables
Plug 'scrooloose/nerdcommenter'                            " commenting
Plug 'scrooloose/nerdtree'                                 " file navigation
Plug 'scrooloose/syntastic'                                " syntax checking
Plug 'AndrewRadev/splitjoin.vim'                           " switch between single-line and multi-line blocks

call plug#end()

"""""""""""""""""""""""

" EasyAlign Configuration
vmap <Enter> <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)


" NERD Tree Configuration

"" Open NERDTree all the time.
"autocmd vimenter * NERDTree

"" Close NERDTree if everything else is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif



colorscheme molokai


" Return to the last location viewed when reopening a file.
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif |
 \ autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

