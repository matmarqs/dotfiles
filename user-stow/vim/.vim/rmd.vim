setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal backspace=indent,eol,start

map j gj
map k gk
map $ g$

" normal mode
nnoremap <Leader>c :w<CR>:!echo<Space>"require(rmarkdown);<Space>render('<c-r>%')"<Space>\|<Space>R<Space>--vanilla<CR><CR>
nnoremap <Leader>o :!zathura --fork %:t:r.pdf<CR><CR>

" insert mode, Programming
inoremap <Leader>S ```{bash eval=F}<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>s ``<++><Esc>4hi

" insert mode, LaTeX
inoremap <Leader>e $$<++><Esc>F$i
inoremap <Leader>E \[<CR><CR>\]<CR><++><Esc>2ki
inoremap <Leader>dv \dv{}{<++>}<Esc>Fvla
inoremap <Leader>dp \pdv{}{<++>}<Esc>Fvla
inoremap <Leader>U \unit{}<Esc>i
inoremap <Leader>f \frac{}{<++>}<++><Esc>Fcla
inoremap <Leader>m21 \begin{bmatrix}<CR><Space>\\<Space><++><CR>\end{bmatrix}<CR><++><Esc>2k00i
inoremap <Leader>m22 \begin{bmatrix}<CR> & <++> \\<CR><++> & <++><CR>\end{bmatrix}<CR><++><Esc>3k00i
inoremap <Leader>t \text{}<++><Esc>F}i
inoremap <Leader>c \begin{cases}<CR><CR>\end{cases}<CR><++><Esc>2ki
inoremap <Leader>T \begin{theorem}[\textbf{}]<CR>\rm<Space><++><CR>\end{theorem}<CR><CR><++><Esc>4kf]hi
inoremap <Leader>D \begin{defi}[\textbf{}]<CR>\rm<Space><++><CR>\end{defi}<CR><CR><++><Esc>4kf]hi
inoremap <Leader>P \begin{proof}<CR>\rm<Space><CR>\end{proof}<CR><CR><++><Esc>3ka
