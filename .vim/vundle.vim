" ----------------------------------------
" Vundle
" ----------------------------------------

set nocompatible " be iMproved
filetype off     " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" Source all the plugins with a global variable set that ensures only the
" Plugin 'name' code will be called.
let g:vundle_installing_plugins = 1
for file in split(glob('$HOME/.vim/vundle.d/*.vim'), '\n')
  exe 'source' fnameescape(file)
endfor
unlet g:vundle_installing_plugins

call vundle#end()
