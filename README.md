# Installation
## Repository
```bash
cd
git clone git@github.com:idoa01/dotfiles.git dotfiles
git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/.vim/bundle/Vundle.vim
git submodule init
git submodule update --init --recursive
```

## GitHub
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

## bash
link files to home:
```
  1 .aliases -> /home/ido/dotfiles/.aliases
  2 .bash_aliases -> /home/ido/dotfiles/.bash_aliases
  3 .cshrc -> /home/ido/dotfiles/.cshrc
  4 .bashrc -> /home/ido/dotfiles/.bashrc
  5 .dircolors -> /home/ido/dotfiles/.dircolors
  6 .gitconfig -> /home/ido/dotfiles/.gitconfig
  7 .screenrc -> /home/ido/dotfiles/.screenrc
  8 .mongorc2.js -> /home/ido/dotfiles/.mongorc.js
  9 .vimpagerrc -> /home/ido/dotfiles/.vimpagerrc
 10 .pryrc -> /home/ido/dotfiles/.pryrc
 11 .bash -> dotfiles/.bash/
 12 .vim -> /home/ido/dotfiles/.vim/
 13 .vimrc -> /home/ido/dotfiles/.vimrc
 14 .fonts -> /home/ido/dotfiles/.fonts/
```

## vim
1. install fonts for airline: https://powerline.readthedocs.org/en/master/installation.html, http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
2. install silversearcher: `aptitude install silversearcher-ag`
3. compile YouCompleteMe: https://github.com/Valloric/YouCompleteMe#installation
4. install plugins from command line: `vim +PluginInstall +qall`

# Adding submodules:
------------------
```bash
cd ~/dotfiles
git submodule add <git://github ...> .vim/bundle/<submodule-name>
```
