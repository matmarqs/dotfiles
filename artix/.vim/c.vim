setlocal cindent
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal backspace=indent,eol,start

" " Macros
" Compilar
nnoremap <Leader>C :!clear<CR><CR>:w<CR>:!gcc<Space>-O2<Space>-lm<Space>%<CR><CR>:!./a.out<CR>
" Macros
"inoremap <Leader>ii #include <stdio.h><CR><CR><CR><++><Esc>2ki
inoremap <Leader>il #include <stdlib.h><CR>
inoremap <Leader>ic #include <ctype.h><CR>
inoremap <Leader>is #include <string.h><CR>
inoremap <Leader>ia #include <stdarg.h><CR>
inoremap <Leader>im #include <math.h><CR>
" Funcoes
inoremap <Leader>v void (<++>) {<CR><++>;<CR>}<CR><++><Esc>3kf(i
inoremap <Leader>d double (<++>) {<CR><++>;<CR>}<CR><++><Esc>3kf(i
inoremap <Leader>I int (<++>) {<CR><++>;<CR>}<CR><++><Esc>3kf(i
inoremap <Leader>c /*  */<Esc>2hi
" Function prototypes
nnoremap çF "fyy/\/\*<Space>DEFINITIONS<CR>"fp$T)C;<Esc>
