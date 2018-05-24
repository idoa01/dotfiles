" Source all the plugin files again, this time loading their configuration.
for file in split(glob('~/.vim/plug.d/*.vim'), '\n')
  exe 'source' file
endfor
