if exists('g:plug_installing_plugins')
  Plug 'sjl/gundo.vim'
  finish
endif

map <leader>g :GundoToggle<CR>
