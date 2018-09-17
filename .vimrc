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

" http://vim.wikia.com/wiki/Backspace_and_delete_problems
" Had to add this after upgrading work vim to 7.4; backspace would not go
" beyond where insert mode started (argh).
set backspace=indent,eol,start

set nocompatible
set omnifunc=syntaxcomplete#Complete

" Folding is off for now, since it causes huge slowdowns on large
" files/pastes.
"set foldmethod=syntax

let g:colorizer_auto_filetype = 'css,html'
let Tlist_Auto_Open           = 1
let Tlist_Exit_OnlyWindow     = 1

set listchars = listchars=tab:>-,trail:.,extends:>,precedes:<,eol:$
set list

set tags=tags/;

nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F3> :set spell spelllang=en_us<CR>
nnoremap <silent> <F4> :set spell&<CR>
"asetlocal spell spelllang=en_us

nnoremap <silent> \ :bnext<CR>
nnoremap <silent>  :bprev<CR>

" Save files with sudo. (nabbed from https://stackoverflow.com/a/7078429)
cmap w!! w !sudo tee > /dev/null %

"""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'     " edit many places at once
Plug 'bling/vim-airline'                " better status line
Plug 'edkolev/tmuxline.vim'             " generate airline config for tmux
Plug 'vim-airline/vim-airline-themes'   " airline themes
Plug 'kien/ctrlp.vim'                   " fuzzy file finding
Plug 'nathanaelkane/vim-indent-guides'  " mark indentation levels
Plug 'junegunn/vim-easy-align'          " align on delimiters
Plug 'junegunn/rainbow_parentheses.vim' " parentheses marking
Plug 'tpope/vim-abolish'                " text transformations and things
Plug 'tpope/vim-fugitive'               " git integration
Plug 'tpope/vim-endwise'                " add `end` in Ruby
Plug 'vim-ruby/vim-ruby'                " complete Ruby support
Plug 'fatih/vim-go'                     " golang support
Plug 'tomasr/molokai'                   " color theme
Plug 'sukima/xmledit'                   " XML/HTML/SGML editing
Plug 'elzr/vim-json'                    " better JSON syntax highlighting
Plug 'chr4/nginx.vim'                   " nginx config files
Plug 'chr4/sslsecure.vim'               " highlight insecure SSL/TLS options
Plug 'pangloss/vim-javascript'          " javascript indentation/highlighting
Plug 'mxw/vim-jsx'                      " react jsx highlighting
Plug 'noprompt/vim-yardoc'              " syntax highlighting within comments
Plug 'shepherdwind/vim-velocity'        " syntax highlighting for velocity
Plug 'saltstack/salt-vim'               " syntax highlighting for Salt
Plug 'hallison/vim-ruby-sinatra'        " sinatra syntax highlighting
Plug 'chrisbra/Colorizer'               " highlight colors within text
Plug 'chrisbra/csv.vim'                 " view CSV files as tables
Plug 'derekwyatt/vim-scala'             " syntax highlighting for Scala
Plug 'scrooloose/nerdcommenter'         " commenting
Plug 'scrooloose/nerdtree'              " file navigation
"Plug 'scrooloose/syntastic'             " syntax checking
Plug 'AndrewRadev/splitjoin.vim'        " switch between single-line and multi-line blocks
Plug 'michaeljsmith/vim-indent-object'  " text objects based on indentation level
Plug 'kana/vim-fakeclip'                " clipboard access for vim without +clipboard
Plug 'JulesWang/css.vim'                " necessary for Vim version < 7.4
Plug 'cakebaker/scss-syntax.vim'        " syntax highlighting for SASS
Plug 'mustache/vim-mustache-handlebars' " syntax highlighting for handlebars
Plug 'tpope/vim-speeddating'            " advanced date formatting capabilities
Plug 'jceb/vim-orgmode'                 " for project/task management
Plug 'w0rp/ale'                         " async linter for basically everything
" Plug 'RRethy/vim-illuminate'            " highlight word under the cursor

call plug#end()

"""""""""""""""""""""""


" vim-go wants to be on a very recent version of vim, which isn't available
" everywhere I run vim. This suppresses the super annoying warning that is
" otherwise generated during startup.
let g:go_version_warning = 0


" vim-airline Configuration
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
set noshowmode

" ctrl-p Configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|node_modules|bower_components|build|dist|tmp$',
  \ 'file': '\v\.(exe|so|dll|o)$',
  \ }

" vim-indent-guides Configuration
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=53
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=52

au VimEnter * IndentGuidesEnable

" EasyAlign Configuration
vmap <Enter> <Plug>(EasyAlign)
vmap <Leader>a <Plug>(EasyAlign)

" syntastic Configuration
let g:syntastic_javascript_checkers = ['jsxhint']

" NERD Tree Configuration

"" Open NERDTree all the time.
"autocmd vimenter * NERDTree

"" Close NERDTree if everything else is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Velocity - add special extension for AWS API Gateway
au BufNewFile,BufRead *.json.vtl set ft=velocity

" Handlbars config
let g:mustache_abbreviations = 1

" Rainbow Parentheses Configuration
au VimEnter * RainbowParentheses

" vim-flake8 Configuration
let g:flake8_show_in_gutter=1

" Remove parentheses on ctrl-P
nmap <C-P> :s/(/ /g<CR>:s/)//g<CR>:nohl<CR>

colorscheme molokai


" Misc Helpers
autocmd BufRead,BufNewFile *.md set syntax=markdown
autocmd BufRead,BufNewFile ~/projects/inGraphs/common-templates/* set syntax=yaml
autocmd BufRead,BufNewFile ~/projects/ingraphs-from-cli/* set syntax=yaml
autocmd BufRead,BufNewFile */config/**/*.src set syntax=xml
autocmd BufRead,BufNewFile ~/projects/**/*.go set expandtab!
autocmd BufRead,BufNewFile ~/projects/**/*.c set expandtab!
autocmd BufRead,BufNewFile ~/projects/**/*.h set expandtab!

" Perform syntax highlighting from the start of the file every time. Hurts
" performance but fixes incorrect highlighting before scrolling around.
autocmd BufEnter * :syntax sync fromstart

" tell vim to keep a backup file
set backup

" tell vim where to put its backup files
set backupdir=~/.vim-runtime/backup/

" tell vim where to put swap files
set dir=~/.vim-runtime/swap/



" Fix YAML syntax highlighting
"autocmd FileType yaml execute
"      \'syn match yamlBlockMappingKey /^\s*\zs.*\ze\s*:\%(\s\|$\)/'

" Darken listchars, remove background overrides
hi NonText ctermfg=238 ctermbg=none guifg=gray
hi Normal              ctermbg=none
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


" http://vim.wikia.com/wiki/Move_to_next/previous_line_with_same_indentation
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>
