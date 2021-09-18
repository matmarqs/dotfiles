" Aplicando alteracoes ao salvar o .vimrc
"autocmd BufWritePost .vimrc source %

" Clipboard (Eh necessario ter o gvim ao inves do vim, pois ele tem X support)
"vnoremap <C-c> "+y
"inoremap <C-v> <Esc>"+pa
set clipboard=unnamedplus

" Configuracoes basicas
set nohlsearch
set number relativenumber

" From defaults.vim
set timeoutlen=1500
set ttimeoutlen=10
set history=200

" Plugins
set showcmd
filetype plugin on
syntax on

" Colors
hi Visual cterm=reverse ctermbg=234

" " Shorcuts
" A exclamacao '!' depois do comando significa para ligar ou desligar.
nnoremap ;] :set nu! rnu!<Enter>

" " Python
autocmd FileType python inoremap [ []<Esc>i
autocmd FileType python inoremap ( ()<Esc>i
autocmd FileType python inoremap { {}<Esc>i

" Removendo espacos em branco flutuantes para arquivos .py
autocmd BufWritePre *.py :%s/\s\+$//e
