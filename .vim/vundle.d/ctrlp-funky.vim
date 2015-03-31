if exists('g:vundle_installing_plugins')
  Plugin 'tacahiroy/ctrlp-funky'
  finish
endif

let g:ctrlp_funky_syntax_highlight = 1

" Leader Commands
nnoremap <Leader>fu :CtrlPFunky<Cr>
  " narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
