## Setup

Clone dotfiles

```bash
git clone https://github.com/frenangomes/dotfiles
```

### NEOVIM and TMUX

* Install neovim: `brew install nvim`
* Install tmux: `brew install tmux`
* Install the package manager:

https://github.com/wbthomason/packer.nvim#quickstart

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

* Execute the setup script to setup both neovim and tmux:

```bash
bash $HOME/dotfiles/setup
```

* Open neovim and install the plugins

```
:PackerInstall
```

and

```
:LspInsall elixirls
```

* Install plugins with [tmux-plugins](https://github.com/tmux-plugins/tpm)

#### Fixing neovim background color on tmux

* .zshrc (or any profile you're using on your terminal)
```
if [[ $TERM == xterm ]]; then TERM=xterm-256color; fi
```

* Ensure that you have the config bellow within `.tmux.conf`
```
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color*:Tc"
```

More info: https://sunaku.github.io/vim-256color-bce.html
