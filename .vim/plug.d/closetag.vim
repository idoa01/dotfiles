if exists('g:plug_installing_plugins')
  Plug 'docunext/closetag.vim'
  finish
endif

autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/plugged/closetag.vim/plugin/closetag.vim
