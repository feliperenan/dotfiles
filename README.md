## Setup

Clone dotfiles
```bash
git clone https://github.com/frenangomes/dotfiles
```

### NEOVIM
Install [vim-plug](https://github.com/junegunn/vim-plug)

Make sure that you have `~/.config/nvim/init.vim` and add it there:
```
source $HOME/dotfiles/vim/init.vim
```

```VIM
:PlugInstall
```

### VIM
Install [vim-plug](https://github.com/junegunn/vim-plug)

Make sure that you have `~/.vimrc` and add it there:
```
source $HOME/dotfiles/vim/init.vim
```

```VIM
:PlugInstall
```

### CTAGS with GIT

Configure GIT
```bash
git config --global init.templatedir '~/.git_template'
git config --global alias.ctags '!.git/hooks/ctags'
```

Copy `.git_template` to your home directory
```bash
cp -r ~/dotfiles/.git_template ~
```

You may need to re-initialize the git inside your project:
```bash
git init
```

Let ctags executable:
```bash
chmod +x .git/hooks/ctags
```

Inside your project:
```bash
git ctags
```

Now ctags will be update automatically after each git commands.

More info [here](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)

So far this commit, CTAGS doesn't support Elixir by default, consider use this [elixir-ctags](https://github.com/mmorearty/elixir-ctags).

### TMUX

Copy `~/dotfiles/tmux/.tmux.conf` to your home

```bash
cp ~/dotfiles/tmux/.tmux.conf ~
```

Install plugins with [tmux-plugins](https://github.com/tmux-plugins/tpm)
