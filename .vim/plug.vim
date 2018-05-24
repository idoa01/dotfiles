" ----------------------------------------
" Vim-Plug
" ----------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Source all the plugins with a global variable set that ensures only the
" Plugin 'name' code will be called.
let g:plug_installing_plugins = 1
for file in split(glob('$HOME/.vim/plug.d/*.vim'), '\n')
  exe 'source' fnameescape(file)
endfor
unlet g:plug_installing_plugins

call plug#end()

