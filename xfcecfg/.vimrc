"" Aplicando alteracoes ao salvar o .vimrc
"autocmd BufWritePost .vimrc source %

" Clipboard (Eh necessario ter o gvim ao inves do vim, pois ele tem X support)
"vnoremap <C-c> "+y
"inoremap <C-v> <Esc>"+pa
set clipboard=unnamedplus

" Configuracoes basicas
set nohlsearch
set number relativenumber

" From defaults.vim
set timeoutlen=2000
set ttimeoutlen=10
set history=200

" " Plugins
set showcmd
filetype plugin on
syntax on
" "

" " Colors
hi Visual cterm=reverse ctermbg=234
" "

" " Shorcuts
" A exclamacao '!' depois do comando significa para ligar ou desligar.
nnoremap ,n :set nu! rnu!<CR>
" "

" " Geral
nnoremap ;; i<Esc>/<++><CR>"_c4l
inoremap ;; <Esc>/<++><CR>"_c4l
nnoremap <CR> o<Esc>
" "

" " LaTeX
" "
" Compilar um arquivo para pdf na mesma pasta com o atalho ;c
autocmd FileType tex nnoremap ;c :w<CR>:!pdflatex %<CR><CR>
autocmd FileType tex nnoremap ;o :!zathura --fork %:t:r.pdf<CR><CR>
" Macros
autocmd FileType tex inoremap ;ee $  $<++><Esc>F$hi
autocmd FileType tex inoremap ;eq $$  $$<CR><CR><++><Esc>2ki
autocmd FileType tex inoremap ;es $$<CR><CR>$$<CR><CR><++><Esc>3ki
autocmd FileType tex inoremap ;dv \dv{}{<++>}<Esc>Fvla
autocmd FileType tex inoremap ;dp \pdv{}{<++>}<Esc>Fvla
autocmd FileType tex inoremap ;u \unit{}<Esc>i
autocmd FileType tex inoremap ;n <CR>\n<CR><CR>
autocmd FileType tex inoremap ;b \textbf{}<Esc>i
autocmd FileType tex inoremap ;i \textit{}<Esc>i
autocmd FileType tex inoremap ;f \frac{}{<++>}<++><Esc>Fcla
autocmd FileType tex inoremap ;t \begin{theorem}[\textbf{}]<CR><BackSpace>\rm<Space><++><CR>\end{theorem}<CR><CR><++><Esc>4kf]hi
autocmd FileType tex inoremap ;def \begin{defi}[\textbf{}]<CR><BackSpace>\rm<Space><++><CR>\end{defi}<CR><CR><++><Esc>4kf]hi
autocmd FileType tex inoremap ;p \begin{proof}<CR><BackSpace>\rm<Space><CR>\end{proof}<CR><CR><++><Esc>3ka
autocmd FileType tex inoremap ;ob \begin{obs}<CR><BackSpace>\rm<Space><CR>\end{obs}<CR><CR><++><Esc>3ka
autocmd FileType tex inoremap ;s \section{}<CR><CR><++><Esc>2kf{a
autocmd FileType tex inoremap ;l \begin{lstlisting}<CR><Tab><CR>\end{lstlisting}<CR><CR><++><Esc>3ka
autocmd FileType tex inoremap ;m21 \begin{bmatrix}<CR><Space>\\<Space><++><CR>\end{bmatrix}<CR><++><Esc>2k00i 
autocmd FileType tex inoremap ;m22 \begin{bmatrix}<CR> & <++> \\<CR><++> & <++><CR>\end{bmatrix}<CR><++><Esc>3k00i 
" "
" "

" " Python
" "
autocmd FileType python inoremap [ []<Esc>i
autocmd FileType python inoremap ( ()<Esc>i
autocmd FileType python inoremap { {}<Esc>i

" Removendo espacos em branco flutuantes para arquivos .py
autocmd BufWritePre *.py :%s/\s\+$//e
" "
" "

" " C
" "
autocmd FileType c inoremap ;ii #include <stdio.h><CR><CR><CR><++><Esc>2ki
" "
" "

" " R
" "
" Compilar
autocmd FileType rmd map ;c :w<CR>:!echo<Space>"require(rmarkdown);<Space>render('<c-r>%')"<Space>\|<Space>R<Space>--vanilla<CR><CR>
" Macros
autocmd FileType rmd inoremap ;ss ```{bash eval=F}<CR><CR>```<CR><CR><++><Esc>3ki
autocmd FileType rmd inoremap ;sh ```{bash}<CR><CR>```<CR><CR><++><Esc>3ki
autocmd FileType rmd inoremap ;sc ``<++><Esc>4hi
" "
" "
