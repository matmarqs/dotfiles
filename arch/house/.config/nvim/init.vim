" " plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

let mapleader = "ç"
let maplocalleader = "Ç"

" ### GENERAL ###
set clipboard=unnamedplus
set nohlsearch nu rnu
set tabstop=4 softtabstop=4 shiftwidth=4 backspace=indent,eol,start expandtab
set timeoutlen=2000 ttimeoutlen=10 history=200
map Q :w!<CR>

set showcmd
" i have my own indents
filetype indent off
" syntax by treesitter
syntax on

" default vim cursor
set guicursor=

" colors
"set background=light
hi Keyword ctermfg=211
hi Conditional ctermfg=211
hi Repeat ctermfg=211
hi Function ctermfg=117
hi TSMethod ctermfg=117
hi Special ctermfg=223
hi TSFuncBuiltin ctermfg=048
hi Type ctermfg=002
hi Identifier ctermfg=051
hi Comment ctermfg=248
"hi Comment ctermfg=211
hi Visual cterm=reverse ctermbg=234
hi Statement ctermfg=180
hi LineNr ctermfg=216
hi CursorLineNr ctermfg=216
hi Pmenu ctermbg=016 ctermfg=229
hi PmenuSel ctermbg=111 ctermfg=016
hi StatusLine ctermfg=143 ctermbg=016

" macros
nnoremap <Leader>n :set rnu!<CR>
nnoremap <Leader>d 0D
nnoremap <Leader><Leader> i<Esc>/<++><CR>"_c4l
inoremap <Leader><Leader> <Esc>/<++><CR>"_c4l
nnoremap <CR> o<Esc>0d$

" removing trailing white spaces in Python, C, Lua, Vim
autocmd BufWritePre *.py,*.c,*.lua,*.vim :%s/\s\+$//e

" C, Python, Lua
autocmd BufRead,BufNewfile *.c,*.h source /home/sekai/.vim/c.vim
autocmd BufRead,BufNewFile *.py source /home/sekai/.vim/python-neo.vim
autocmd BufRead,BufNewFile *.lua source /home/sekai/.vim/lua.vim
" "

" removing trailing white spaces in LaTeX, R Markdown
autocmd BufWritePre *.tex,*.rmd :%s/\s\+$//e

" LaTeX, RMarkdown
autocmd BufRead,BufNewFile *.tex source /home/sekai/.vim/tex.vim
autocmd BufRead,BufNewFile *.rmd source /home/sekai/.vim/rmd.vim

" map Esc to quit Insert Mode when in terminal
tnoremap <Esc> <C-\><C-n>

" vim's builtin autocompletion maps
inoremap <C-]> <C-x><C-]>
inoremap <C-f> <C-x><C-f>
inoremap <C-d> <C-x><C-d>

" " plugin nvim-cmp: autocompletion
set completeopt=menu,menuone,noselect
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        --elseif luasnip.expand_or_jumpable() then
        --  luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        --elseif luasnip.jumpable(-1) then
        --  luasnip.jump(-1)
        else
          fallback()
        end
      end,
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer', keyword_length = 5 },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['ccls'].setup {
    capabilities = capabilities
  }
  -- require('lspconfig')['pylsp'].setup {
  --   capabilities = capabilities
  -- }
EOF

" " plugin: nvim-treesitter: better highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
-- Modules and its options go here
highlight = { enable = true },
}
EOF
