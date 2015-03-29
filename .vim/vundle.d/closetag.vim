if exists('g:vundle_installing_plugins')
  Plugin 'docunext/closetag.vim.git'
  finish
endif

autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim
