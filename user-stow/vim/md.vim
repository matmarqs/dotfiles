setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal backspace=indent,eol,start

map j gj
map k gk
map $ g$

nnoremap <Leader>m :MarkdownPreview<CR>
nnoremap <Leader>s "xciW``<Esc>"xP

" insert mode, Programming
inoremap <Leader>S ```bash<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>J ```js<CR>```<Esc>k$
inoremap <Leader>C ```c<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>P ```python<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>L ```lua<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>A ```assembly<CR><CR>```<CR><++><Esc>2ki
inoremap <Leader>s ``<Esc>i

" insert mode, LaTeX
inoremap <Leader>e $$<Esc>i
inoremap <Leader>E $$<CR><CR>$$<CR><++><Esc>2ki
