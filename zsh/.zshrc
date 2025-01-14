# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Important variables
EDITOR="nvim"
TMUX_CONFIG="${HOME}/.tmux.conf"
ZSH_CONFIG="${HOME}/.zshrc"
NVIM_CONFIG="${HOME}/.config/nvim/init.lua"

# Set the directory zinit plugins will be installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias cat='ccat'
alias lvim='/Users/feliperenan/.local/bin/lvim'
alias vimconf="$EDITOR $NVIM_CONFIG"
alias zconf="$EDITOR $ZSH_CONFIG"
alias tmuxconf="$EDITOR $TMUX_CONFIG"

# Aliases (GIT)
alias g='git status -sb'
alias gs='git status'
alias gcm='git checkout master'
alias grm='git rebase master'
alias gc='git checkout'
# This relies on FZF, so make FZF and FZF-GIT are installed.
# https://github.com/junegunn/fzf
# https://github.com/junegunn/fzf-git.sh
alias gcb='_fzf_git_branches --no-multi | xargs git checkout'
alias gr='git rebase'
alias gl='git log'
alias gp='git pull'
alias gpush='git push -u origin HEAD'
alias fpush='git push origin HEAD --force-with-lease'
alias delete-branchs='git branch | xargs git branch -D'
alias prcompare='gh pr create -w'
alias k='kubectl'

# Enable history at iex console
export ERL_AFLAGS="-kernel shell_history enabled"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.fzf-git/fzf-git.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

# Set RG for FZF when RG is available
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# ASDF
. "$HOME/.asdf/asdf.sh"

