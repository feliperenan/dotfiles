## Setup

Clone dotfiles
```bash
git clone https://github.com/frenangomes/dotfiles
```

### NEOVIM
Install [vim-plug](https://github.com/junegunn/vim-plug)

Make sure that you have `~/.config/nvim/init.vim` and add it there:
```
source $HOME/dotfiles/init.vim
```

```VIM
:PlugInstall
```

### VIM
Install [vim-plug](https://github.com/junegunn/vim-plug)

Make sure that you have `~/.vimrc` and add it there:
```
source $HOME/dotfiles/init.vim
```

```VIM
:PlugInstall
```

### CTAGS with GIT
Copy `.git_template` to your home directory
```bash
cp -r ~/dotfiles/.git_template ~
```

Let ctags executable:
```bash
chmod +x .git/hooks/ctags
```

Inside your project:
```bash
git ctags
```

Now ctags will be update automatically after each git commit.

More info [here](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)

### TMUX

Copy `~/dotfiles/.tmux.conf` to your home

```bash
cp ~/dotfiles/.tmux.conf ~
```

Install plugins with [tmux-plugins](https://github.com/tmux-plugins/tpm)
