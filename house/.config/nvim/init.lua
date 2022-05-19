-- To install wbthomason/packer.nvim:
--   git clone --depth 1 https://github.com/wbthomason/packer.nvim\
--    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- After that, we run ":PackerSync" (using also this file as ~/.config/nvim/init.lua)
--
-- To install "r_language_server"
--   > sudo R
--   > install.packages("languageserver")

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'nvim-treesitter/nvim-treesitter' -- Better highlighting
end)

-- Leader key
vim.api.nvim_command('let mapleader = "ç"')
vim.api.nvim_command('let maplocalleader = "Ç"')

-- General
vim.api.nvim_command('set clipboard=unnamedplus')
vim.api.nvim_command('set nohlsearch nu rnu')
vim.api.nvim_command('set tabstop=4 softtabstop=4 shiftwidth=4 backspace=indent,eol,start expandtab')
vim.api.nvim_command('set timeoutlen=2000 ttimeoutlen=10 history=200')
vim.api.nvim_command('map Q :w!<CR>')
vim.api.nvim_command('map <C-z> <C-a>')
vim.api.nvim_command('set guicursor=')

-- Languages
vim.api.nvim_command('set showcmd')
vim.api.nvim_command('filetype indent off')
--vim.api.nvim_command('syntax on')

---- Aesthetics
vim.api.nvim_command('hi Keyword ctermfg=211')
vim.api.nvim_command('hi Conditional ctermfg=211')
vim.api.nvim_command('hi Repeat ctermfg=211')
vim.api.nvim_command('hi Function ctermfg=117')
vim.api.nvim_command('hi TSMethod ctermfg=117')
vim.api.nvim_command('hi Special ctermfg=223')
vim.api.nvim_command('hi TSFuncBuiltin ctermfg=048')
vim.api.nvim_command('hi Type ctermfg=002')
vim.api.nvim_command('hi Identifier ctermfg=051')
vim.api.nvim_command('hi Comment ctermfg=248')
vim.api.nvim_command('hi Visual cterm=reverse ctermbg=234')
--vim.api.nvim_command('hi Statement ctermfg=180')
vim.api.nvim_command('hi LineNr ctermfg=216')
vim.api.nvim_command('hi CursorLineNr ctermfg=216')
vim.api.nvim_command('hi Pmenu ctermbg=016 ctermfg=229')
vim.api.nvim_command('hi PmenuSel ctermbg=111 ctermfg=016')
vim.api.nvim_command('hi StatusLine ctermfg=051 ctermbg=016')
--vim.api.nvim_command('hi StatusLine ctermfg=143 ctermbg=016')

-- Macros
vim.api.nvim_command('nnoremap <Leader>n :set rnu!<CR>')
vim.api.nvim_command('nnoremap <Leader>d 0D')
vim.api.nvim_command('nnoremap <Leader><Leader> i<Esc>/<++><CR>"_c4l')
vim.api.nvim_command('inoremap <Leader><Leader> <Esc>/<++><CR>"_c4l')
vim.api.nvim_command('nnoremap <CR> o<Esc>0d$')
vim.api.nvim_command('inoremap <C-f> <C-x><C-f>')

-- map Esc to quit Insert Mode when in terminal
vim.api.nvim_command('tnoremap <Esc> <C-\\><C-n>')

-- removing trailing white spaces
vim.api.nvim_command('autocmd BufWritePre * :%s/\\s\\+$//e')

-- importing language configs
vim.api.nvim_command('autocmd BufRead,BufNewfile *.c,*.h source /home/sekai/.vim/c.vim')
vim.api.nvim_command('autocmd BufRead,BufNewFile *.py source /home/sekai/.vim/python-neo.vim')
vim.api.nvim_command('autocmd BufRead,BufNewFile *.lua source /home/sekai/.vim/lua.vim')
vim.api.nvim_command('autocmd BufRead,BufNewFile *.tex source /home/sekai/.vim/tex.vim')
vim.api.nvim_command('autocmd BufRead,BufNewFile *.rmd source /home/sekai/.vim/rmd.vim')


--- Plugins

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pylsp', 'texlab', 'r_language_server' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-c>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }
}

require'nvim-treesitter.configs'.setup {
-- Modules and its options go here
highlight = { enable = true },
}
