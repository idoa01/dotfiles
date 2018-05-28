# idoa01's DotFiles

## Installation
```bash
cd
git clone git@github.com:idoa01/dotfiles.git dotfiles
vim +PlugInstall +qall
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
 11 .bash -> /home/ido/dotfiles/.bash/
 12 .vim -> /home/ido/dotfiles/.vim/
 13 .vimrc -> /home/ido/dotfiles/.vimrc
 14 .fonts -> /home/ido/dotfiles/.fonts/
 15 .tmux -> /home/ido/dotfiles/.tmux
```

## General Requirements
  1. [bash-git-prompt](https://github.com/magicmonty/bash-git-prompt) fancy bash prompt for git users
    a. `brew install bash-git-prompt`
  2. [Source Code Nerd Font Complete](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts) Custom font for bash and vim
    a. `brew tap caskroom/fonts`
    b. `brew cask install font-hack-nerd-font`
    c. setup Terminal with Hack-Nerd-Font
  3. [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) Fast code line searches
    a. `brew install the_silver_searcher`

## Plugin Requirements
  1. [Fugitive](https://github.com/tpope/vim-fugitive) Requires Git to be
     installed.
  2. [Ale](https://github.com/w0rp/ale) Uses various linding and style
     checking tools that are sepately installed.
  3. [fzf.vim](https://github.com/junegunn/fzf.vim) Requires
     [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) to be
     installed.
  4. [Source Code Nerd Font Complete](https://git.io/vPBU6) The custom font I'm using
     for vim-airline and vim-devicons.
