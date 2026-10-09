setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal backspace=indent,eol,start

map j gj
map k gk
map $ g$

" normal mode
"nnoremap <Leader>c :w<CR>:!pdflatex<Space>-shell-escape<Space>%<CR><CR>
nnoremap <Leader>c :w<CR>:!lualatex<Space>-shell-escape<Space>%<CR><CR>
"nnoremap <LocalLeader>c :w<CR>:!pdflatex<Space>%<CR><CR>:!latexmk<Space>%<CR><CR>:!pdflatex<Space>%<CR><CR>:!pdflatex<Space>%<CR><CR>
nnoremap <LocalLeader>c :w<CR>:!lualatex<Space>%<CR><CR>:!latexmk<Space>%<CR><CR>:!lualatex<Space>%<CR><CR>:!lualatex<Space>%<CR><CR>
nnoremap <Leader>o :!zathura --fork %:t:r.pdf<CR><CR>

" insert mode
inoremap <Leader>e $$<++><Esc>F$i
"inoremap <Leader>E $$<CR><CR>$$<CR><++><Esc>2ki
inoremap <Leader>c \begin{cases}<CR><CR>\end{cases}<CR><++><Esc>2ki
inoremap <Leader>dv \dv{}{<++>}<Esc>Fvla
inoremap <Leader>dp \pdv{}{<++>}<Esc>Fvla
"inoremap <Leader>pd \pd{}{<++>}<++><Esc>Fdla
inoremap <Leader>s \sum_{}^{<++>}<++><Esc>F_la
inoremap <Leader>U \unit{}<Esc>i
inoremap <Leader>n <CR>\n<CR><CR>
inoremap <Leader>b \textbf{}<Esc>i
inoremap <Leader>i \textit{}<Esc>i
inoremap <Leader>t \text{}<Esc>i
inoremap <Leader>I \begin{itemize}<CR>\item <CR>\end{itemize}<CR><++><Esc>2kA
inoremap <Leader>Q \begin{equation}<Space>\label{eq:}<CR><++><CR>\end{equation}<Esc>2k$i
inoremap <Leader>E \begin{example}<Space>\label{ex:}<CR><++><CR>\end{example}<Esc>2k$i
inoremap <Leader>f \frac{}{<++>}<++><Esc>Fcla
inoremap <Leader>T \begin{theorem}[\textbf{}]<Space>\label{th:<++>}<CR><++><CR>\end{theorem}<Esc>2kf]hi
inoremap <Leader>D \begin{definition}[\textbf{}]<Space>\label{def:<++>}<CR><++><CR>\end{definition}<Esc>2kf]hi
"inoremap <Leader>p \python{}<Esc>i
"inoremap <Leader>P \begin{Python}<Space><CR><CR>\end{Python}<Esc>ki
inoremap <Leader>S \section{}<CR><CR><++><Esc>2kf{a
"inoremap <Leader>l \begin{lstlisting}<CR><Tab><CR>\end{lstlisting}<CR><CR><++><Esc>3ka
inoremap <Leader>m21 \begin{pmatrix}<CR><Space>\\<Space><++><CR>\end{pmatrix}<Esc><<A<CR><++><Esc>2k00i
inoremap <Leader>m22 \begin{pmatrix}<CR>& <++> \\<CR><++> & <++><CR>\end{pmatrix}<Esc><<A<CR><++><Esc>3k00i<Space><Esc>i
inoremap <Leader>m33 \begin{pmatrix}<CR>& <++> & <++> \\<CR><++> & <++> & <++> \\<CR><++> & <++> & <++> \\<CR>\end{pmatrix}<Esc><<A<CR><++><Esc>4k00i<Space><Esc>i
"inoremap <Leader>f \begin{frame}<CR><CR>\end{frame}<CR><++><Esc>2ki
inoremap <Leader>F \begin{figure}[H]<CR>\centering<CR>\includegraphics[width=0.6\linewidth]{fig/}<CR>\caption{<++>}<CR>\label{fig:<++>}<CR>\end{figure}<CR><Esc>4k$i
