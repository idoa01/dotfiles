if exists('g:plug_installing_plugins')
  Plug 'AndrewRadev/linediff.vim'
  finish
endif

nnoremap <Leader>ldt :Lindefiff<CR>
nnoremap <Leader>ldo :LinediffReset<CR>
