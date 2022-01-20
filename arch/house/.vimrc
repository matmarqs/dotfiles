" leader keys
let mapleader = "ç"
let maplocalleader = "Ç"
" "

" ### GENERAL ###
set clipboard=unnamedplus         " clipboard
set nohlsearch                    " no highlight search
set nu rnu                        " number and relativenumber by default
set tabstop=4                     " tab is still a tab, but has a length of 4 spaces
set softtabstop=4                 " backspace will take you to tabstops
set shiftwidth=4                  " for just Ctrl+d (<<) and Ctrl+t (>>)
set backspace=indent,eol,start    " more powerful backspaces
set expandtab                     " convert tabs to spaces
"set autoindent                   " autoindent on tabs (not code specific)
" to replace all tabs with 4 spaces in a file run ':%s/\t/    /g'
set timeoutlen=2000
set ttimeoutlen=10
set history=200
map Q :w!<CR>
" "

" plugins
set showcmd
filetype plugin on
syntax on
" "

" colors
hi Visual cterm=reverse ctermbg=234
hi Statement ctermfg=117
hi LineNr ctermfg=216
hi Pmenu ctermbg=025 ctermfg=016
hi PmenuSel ctermbg=111 ctermfg=016
" SeaGreen2      hi Statement ctermfg=83
" PaleVioletRed1 hi Comment ctermfg=211
" Wheat          hi Comment ctermfg=229
" "

" macros. '!' means to toggle
nnoremap <Leader>n :set rnu!<CR>
nnoremap <Leader>d 0D
nnoremap <Leader><Leader> i<Esc>/<++><CR>"_c4l
inoremap <Leader><Leader> <Esc>/<++><CR>"_c4l
nnoremap <CR> o<Esc>0d$
" "


" ### PROGRAMMING LANGUAGES ###

" removing trailing white spaces in some file extensions
autocmd BufWritePre *.py,*.c,*.lua,*.vim :%s/\s\+$//e

" configs for each language
autocmd BufRead,BufNewfile *.c,*.h source $HOME/.vim/c.vim
autocmd BufRead,BufNewFile *.py source $HOME/.vim/python.vim
autocmd BufRead,BufNewFile *.lua source $HOME/.vim/lua.vim
" "


" ### DOCUMENTS ###

" removing trailing white spaces in document languages
autocmd BufWritePre *.tex,*.rmd :%s/\s\+$//e

" sourcing configs
autocmd FileType tex source $HOME/.vim/tex.vim
autocmd FileType rmd source $HOME/.vim/rmd.vim
" "
