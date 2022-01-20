setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal backspace=indent,eol,start

" " macros
inoremap <Leader>c --<Space>
nnoremap <Leader>c a--<Space>
inoremap <Leader>f function<Space>(<++>)<CR><++><CR><BackSpace>end<Esc>2kf<Space>a
nnoremap <Leader>f ifunction<Space>(<++>)<CR><++><CR><BackSpace>end<Esc>2kf<Space>a
inoremap <Leader>if if<Space><Space>then<CR><++><CR><BackSpace><++><Esc>2ki
nnoremap <Leader>if iif<Space><Space>then<CR><++><CR><BackSpace><++><Esc>2ki
inoremap <Leader>e else<CR><CR><BackSpace><++><Esc>kS
nnoremap <Leader>e ielse<CR><CR><BackSpace><++><Esc>kS

" " From /usr/share/vim/vim82/indent/lua.vim

" Vim indent file
" Language:	Lua script
" Maintainer:	Marcus Aurelius Farias <marcus.cf 'at' bol.com.br>
" First Author:	Max Ischenko <mfi 'at' ukr.net>
" Last Change:	2017 Jun 13

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetLuaIndent()

" To make Vim call GetLuaIndent() when it finds '\s*end' or '\s*until'
" on the current line ('else' is default and includes 'elseif').
setlocal indentkeys+=0=end,0=until

setlocal autoindent

" Only define the function once.
if exists("*GetLuaIndent")
  finish
endif

function! GetLuaIndent()
  " Find a non-blank line above the current line.
  let prevlnum = prevnonblank(v:lnum - 1)

  " Hit the start of the file, use zero indent.
  if prevlnum == 0
    return 0
  endif

  " Add a 'shiftwidth' after lines that start a block:
  " 'function', 'if', 'for', 'while', 'repeat', 'else', 'elseif', '{'
  let ind = indent(prevlnum)
  let prevline = getline(prevlnum)
  let midx = match(prevline, '^\s*\%(if\>\|for\>\|while\>\|repeat\>\|else\>\|elseif\>\|do\>\|then\>\)')
  if midx == -1
    let midx = match(prevline, '{\s*$')
    if midx == -1
      let midx = match(prevline, '\<function\>\s*\%(\k\|[.:]\)\{-}\s*(')
    endif
  endif

  if midx != -1
    " Add 'shiftwidth' if what we found previously is not in a comment and
    " an "end" or "until" is not present on the same line.
    if synIDattr(synID(prevlnum, midx + 1, 1), "name") != "luaComment" && prevline !~ '\<end\>\|\<until\>'
      let ind = ind + shiftwidth()
    endif
  endif

  " Subtract a 'shiftwidth' on end, else, elseif, until and '}'
  " This is the part that requires 'indentkeys'.
  let midx = match(getline(v:lnum), '^\s*\%(end\>\|else\>\|elseif\>\|until\>\|}\)')
  if midx != -1 && synIDattr(synID(v:lnum, midx + 1, 1), "name") != "luaComment"
    let ind = ind - shiftwidth()
  endif

  return ind
endfunction
