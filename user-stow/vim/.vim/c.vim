setlocal cindent
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal backspace=indent,eol,start

" " macros
" compile
nnoremap <Leader>C :!clear<CR><CR>:w<CR>:!gcc<Space>-O2<Space>-lm<Space>%<CR><CR>:!./a.out<CR>
" headers
inoremap <Leader>ii #include <stdio.h><CR><CR><CR><++><Esc>2ki
inoremap <Leader>il #include <stdlib.h><CR>
inoremap <Leader>ic #include <ctype.h><CR>
inoremap <Leader>is #include <string.h><CR>
inoremap <Leader>ia #include <stdarg.h><CR>
inoremap <Leader>im #include <math.h><CR>
" functions
inoremap <Leader>v void (<++>) {<CR><++>;<CR>}<CR><++><Esc>3kf(i
inoremap <Leader>d double (<++>) {<CR><++>;<CR>}<CR><++><Esc>3kf(i
inoremap <Leader>I int (<++>) {<CR><++>;<CR>}<CR><++><Esc>3kf(i
inoremap <Leader>m int main(int argc, char *argv[]) {<CR>;<CR>return 0;<CR>}<Esc>2kf;i
inoremap <Leader>c /*  */<Esc>2hi
nnoremap <Leader>c i/*  */<Esc>2hi
" function prototypes
nnoremap çF "fyy/\/\*<Space>DEFINITIONS<CR>"fp$T)C;<Esc>
