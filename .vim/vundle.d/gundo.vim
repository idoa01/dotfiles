if exists('g:vundle_installing_plugins')
  Plugin 'sjl/gundo.vim.git'
  finish
endif

map <leader>g :GundoToggle<CR>
