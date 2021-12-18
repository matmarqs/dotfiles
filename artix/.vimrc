let mapleader = "ç"
let maplocalleader = "Ç"

" " ### GERAL ###
set clipboard=unnamedplus         " Clipboard
set nohlsearch                    " No highlight search
set nu rnu                        " number and relativenumber by default
set tabstop=4                     " tab is still a tab, but has a length of 4 spaces
set softtabstop=4                 " backspace will take you to tabstops
set shiftwidth=4                  " for just Ctrl+d (<<) and Ctrl+t (>>)
set backspace=indent,eol,start    " more powerful backspaces
set expandtab                     " converter tabs em spaces
"set autoindent                   " autoindent on Tabs (not code specific)
" to replace all tabs with 4 spaces in a file run ':%s/\t/    /g'

" From defaults.vim
set timeoutlen=2000
set ttimeoutlen=10
set history=200
map Q :w!<CR>

" " Plugins
set showcmd
filetype plugin on
syntax on

" " Colors
hi Visual cterm=reverse ctermbg=234
hi Statement ctermfg=117
hi LineNr ctermfg=216
hi Pmenu ctermbg=025 ctermfg=016
hi PmenuSel ctermbg=111 ctermfg=016
" SeaGreen2      hi Statement ctermfg=83
" PaleVioletRed1 hi Comment ctermfg=211
" Wheat          hi Comment ctermfg=229

" Macros
" A exclamacao '!' significa ligar ou desligar.
nnoremap <Leader>n :set rnu!<CR>
nnoremap <Leader>d 0D
nnoremap <Leader><Leader> i<Esc>/<++><CR>"_c4l
inoremap <Leader><Leader> <Esc>/<++><CR>"_c4l
nnoremap <CR> o<Esc>0d$
" "


" " ### PROGRAMMING LANGUAGES ###

" Removendo trailing white spaces em Python e C.
autocmd BufWritePre *.py,*.c,*.lua,*.vim :%s/\s\+$//e

" Configuracoes especificas
autocmd BufRead,BufNewfile *.c,*.h source /home/sekai/.vim/c.vim
autocmd BufRead,BufNewFile *.py source /home/sekai/.vim/python.vim
autocmd BufRead,BufNewFile *.lua source /home/sekai/.vim/lua.vim
autocmd BufRead,BufNewFile *.sage source /home/sekai/.vim/sage.vim
" "


" " ### DOCUMENTS ###

" Removendo trailing white spaces em LaTeX e R Markdown
autocmd BufWritePre *.tex,*.rmd :%s/\s\+$//e

autocmd FileType tex source /home/sekai/.vim/tex.vim
autocmd FileType rmd source /home/sekai/.vim/rmd.vim
" "
