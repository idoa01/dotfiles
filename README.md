git clone git@github.com:idoa01/dotfiles.git dotfiles  
git submodule init  
git submodule update --init --recursive  

GitHub
------
**`~/.gitconfig.local:`**
```
[user]
  name = Ido Abramovich
  email = email@company.com
[github]
  user = idoa01
  token = a123uber456secret789ceprivate000key78
[credential]
  helper = osxkeychain
```


Adding submodules:
------------------
1. cd ~/dotfiles
2. git submodule add <git://github ...> .vim/bundle/<submodule-name>


New vim:
-------
1. git clone git@github.com:idoa01/dotfiles.git dotfiles
2. git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/.vim/bundle/Vundle.vim
3. install fonts for airline: https://powerline.readthedocs.org/en/master/installation.html, http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
4. install plugins from command line: `vim +PluginInstall +qall`
5. compile command-t for system: 
   rvm use system
   cd ~/.vim/bundle/command-t/ruby/command-t 
   ruby extconf.rb
   make
6. install silversearcher: `aptitude install silversearcher-ag`
