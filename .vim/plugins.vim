" Source all the plugin files again, this time loading their configuration.
for file in split(glob('~/.vim/vundle.d/*.vim'), '\n')
  exe 'source' file
endfor
