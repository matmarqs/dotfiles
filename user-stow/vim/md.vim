setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal backspace=indent,eol,start

"map j gj
"map k gk
"map $ g$

" normal mode
nnoremap <Leader>c :w<CR>:!pandoc % -t ms -o %:t:r.pdf<CR><CR>
nnoremap <Leader>o :!zathura --fork %:t:r.pdf<CR><CR>

" insert mode, Programming
inoremap <Leader>g ```{=ms}<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>c ``{.c}<++><Esc>F`i
inoremap <Leader>C ```c<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>s ``{.sh}<++><Esc>F`i
inoremap <Leader>S ```sh<CR><CR>```<CR><++><Esc>2ki
"inoremap <Leader>p ``{.python}<++><Esc>F`i
"inoremap <Leader>P ```python<CR><CR>```<CR><++><Esc>2ki
"inoremap <Leader>l ``{.lua}<++><Esc>F`i
"inoremap <Leader>L ```lua<CR><CR>```<CR><++><Esc>2ki

" insert mode, LaTeX
inoremap <Leader>e $$<++><Esc>F$i
inoremap <Leader>E $$<CR><CR>$$<CR><++><Esc>2ki
inoremap <LocalLeader>s \sum_{}^{<++>}<++><Esc>F_la
inoremap <LocalLeader>f \frac{}{<++>}<++><Esc>Fcla
inoremap <LocalLeader>m21 \begin{bmatrix}<CR><Space>\\<Space><++><CR>\end{bmatrix}<CR><++><Esc>2k00i
inoremap <LocalLeader>m22 \begin{bmatrix}<CR> & <++> \\<CR><++> & <++><CR>\end{bmatrix}<CR><++><Esc>3k00i
