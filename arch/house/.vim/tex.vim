setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal backspace=indent,eol,start

map j gj
map k gk
map $ g$

" normal Mode
nnoremap <Leader>c :w<CR>:!pdflatex<Space>%<CR><CR>
nnoremap <LocalLeader>c :w<CR>:!pdflatex<Space>%<CR><CR>:!latexmk<Space>%<CR><CR>:!pdflatex<Space>%<CR><CR>:!pdflatex<Space>%<CR><CR>
nnoremap <Leader>o :!zathura --fork %:t:r.pdf<CR><CR>

" insert Mode
inoremap <Leader>e $$<++><Esc>F$i
inoremap <Leader>E $$<CR><CR>$$<CR><++><Esc>2ki
inoremap <Leader>c \begin{cases}<CR><CR>\end{cases}<CR><++><Esc>2ki
inoremap <Leader>dv \dv{}{<++>}<Esc>Fvla
inoremap <Leader>dp \pdv{}{<++>}<Esc>Fvla
inoremap <Leader>pd \pd{}{<++>}<++><Esc>Fdla
inoremap <Leader>s \sum_{}^{<++>}<++><Esc>F_la
inoremap <Leader>U \unit{}<Esc>i
inoremap <Leader>n <CR>\n<CR><CR>
inoremap <Leader>b \textbf{}<Esc>i
inoremap <Leader>i \textit{}<Esc>i
inoremap <Leader>t \text{}<Esc>i
inoremap <Leader>I \begin{itemize}<CR>\item <CR>\end{itemize}<CR><++><Esc>2kA
inoremap <Leader>f \frac{}{<++>}<++><Esc>Fcla
inoremap <Leader>T \begin{theorem}[\textbf{}]<CR>\rm<Space><++><CR>\end{theorem}<CR><CR><++><Esc>4kf]hi
inoremap <Leader>L \begin{lemma}[\textbf{}]<CR>\rm<Space><++><CR>\end{lemma}<CR><CR><++><Esc>4kf]hi
inoremap <Leader>D \begin{defi}[\textbf{}]<CR>\rm<Space><++><CR>\end{defi}<CR><CR><++><Esc>4kf]hi
inoremap <Leader>P \begin{prop}[\textbf{}]<CR>\rm<Space><++><CR>\end{prop}<CR><CR><++><Esc>4kf]hi
inoremap <Leader>pr \begin{proof}<CR>\rm<Space><CR>\end{proof}<CR><CR><++><Esc>3ka
inoremap <Leader>O \begin{obs}<CR>\rm<Space><CR>\end{obs}<CR><CR><++><Esc>3ka
inoremap <Leader>S \section{}<CR><CR><++><Esc>2kf{a
"inoremap <Leader>l \begin{lstlisting}<CR><Tab><CR>\end{lstlisting}<CR><CR><++><Esc>3ka
inoremap <Leader>m21 \begin{bmatrix}<CR><Space>\\<Space><++><CR>\end{bmatrix}<CR><++><Esc>2k00i
inoremap <Leader>m22 \begin{bmatrix}<CR> & <++> \\<CR><++> & <++><CR>\end{bmatrix}<CR><++><Esc>3k00i
inoremap <Leader>F \begin{frame}<CR><CR>\end{frame}<CR><++><Esc>2ki
