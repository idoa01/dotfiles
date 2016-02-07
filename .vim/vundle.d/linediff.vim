if exists('g:vundle_installing_plugins')
  Plugin 'AndrewRadev/linediff.vim.git'
  finish
endif

nnoremap <Leader>ldt :Lindefiff<CR>
nnoremap <Leader>ldo :LinediffReset<CR>
