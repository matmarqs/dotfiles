" Configuracoes basicas
set nohlsearch
set number relativenumber

" Plugins
set nocompatible
filetype plugin on
syntax on

" Atalhos de configuracoes
nnoremap ,, :set nu! rnu!<Enter>

" " Geral
nnoremap ;; i<Esc>/<++><Enter>"_c4l
inoremap ;; <Esc>/<++><Enter>"_c4l

" " LaTeX
" "
" Compilar um arquivo para pdf na mesma pasta com o atalho ;c
autocmd FileType tex nnoremap ;c :w<Enter>:!pdflatex %<Enter><Enter>
autocmd FileType tex nnoremap ;o :!zathura --fork %:t:r.pdf<Enter><Enter>
" Macros
autocmd FileType tex inoremap ;ee $  $<Space><++><Esc>F$hi
autocmd FileType tex inoremap ;eq $$ e $$<Enter><Enter><++><Esc>2ks
autocmd FileType tex inoremap ;dv \dv{}{<++>}<Esc>Fvla
autocmd FileType tex inoremap ;dp \pdv{}{<++>}<Esc>Fvla
autocmd FileType tex inoremap ;u \unit{}<Esc>i
autocmd FileType tex inoremap ;n <Enter>\n<Enter><Enter>
autocmd FileType tex inoremap ;b \textbf{}<Esc>i
autocmd FileType tex inoremap ;i \textit{}<Esc>i
autocmd FileType tex inoremap ;f \frac{}{<++>}<Esc>Fcla
autocmd FileType tex inoremap ;t \begin{theorem}[\textbf{}]<Enter><BackSpace>\rm<Space><++><Enter>\end{theorem}<Enter><Enter><++><Esc>4kf]hi
autocmd FileType tex inoremap ;def \begin{defi}[\textbf{}]<Enter><BackSpace>\rm<Space><++><Enter>\end{defi}<Enter><Enter><++><Esc>4kf]hi
autocmd FileType tex inoremap ;p \begin{proof}<Enter><BackSpace>\rm<Space><Enter>\end{proof}<Enter><Enter><++><Esc>3ka
autocmd FileType tex inoremap ;ob \begin{obs}<Enter><BackSpace>\rm<Space><Enter>\end{obs}<Enter><Enter><++><Esc>3ka
autocmd FileType tex inoremap ;s \section{}<Enter><Enter><++><Esc>2kf{a
autocmd FileType tex inoremap ;l \begin{lstlisting}<Enter><Tab><Enter>\end{lstlisting}<Enter><Enter><++><Esc>3ka
" "
" "

" " C
autocmd FileType c inoremap ;ii #include <stdio.h><Enter><Enter><Enter><++><Esc>2ki
