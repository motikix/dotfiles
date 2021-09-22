# theme (GitHub Dark Default)
set -x BACKGROUND_COLOR '#0d1117'
set -x FOREGROUND_COLOR '#b3b1ad'
set -x BLACK_COLOR '#484f58'
set -x RED_COLOR '#ff7b72'
set -x GREEN_COLOR '#3fb950'
set -x YELLOW_COLOR '#d29922'
set -x BLUE_COLOR '#58a6ff'
set -x MAGENTA_COLOR '#bc8cff'
set -x CYAN_COLOR '#39c5cf'
set -x WHITE_COLOR '#b3b1ad'
set -x BRIGHT_BLACK_COLOR '#6e7681'
set -x BRIGHT_RED_COLOR '#ffa198'
set -x BRIGHT_GREEN_COLOR '#56d364'
set -x BRIGHT_YELLOW_COLOR '#e3b341'
set -x BRIGHT_BLUE_COLOR '#79c0ff'
set -x BRIGHT_MAGENTA_COLOR '#d2a8ff'
set -x BRIGHT_CYAN_COLOR '#39c5cf'
set -x BRIGHT_WHITE_COLOR '#b3b1ad'

# environments

# lang
set -x LANG en_US.UTF-8

# gpg
set -x GPG_TTY (tty)

# xdg base directory specification
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# bin
set -x PATH $HOME/.local/bin $PATH

# ssh-agent
if type -q ssh-agent
  eval (ssh-agent -c) > /dev/null
end

# asdf
if test -d $HOME/.asdf
  source $HOME/.asdf/asdf.fish
end

# java
if test "$XDG_SESSION_DESKTOP" = "sway"
  set -x _JAVA_AWT_WM_NONREPARENTING 1
end

# go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# rust
set -x PATH $HOME/.cargo/bin $PATH

# haskell
# set -x PATH $HOME/.cabal/bin $PATH
# set -x PATH $HOME/.ghcup/bin $PATH

# node
set -x NPM_CONFIG_PREFIX $HOME/.local

# deno
set -x DENO_INSTALL_ROOT $HOME/.local

# python
set -x PIPENV_VENV_IN_PROJECT true

# flutter
set -x PATH $HOME/flutter/bin $PATH

# fzf
set -x FZF_LEGACY_KEYBINDINGS 1
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git"'
set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "head -n 30 {}"'

# aliases

# neovim
if type -q nvim
  alias vim="nvim"
end

# colordiff
if type -q colordiff
  alias diff="colordiff -up"
else
  alias diff="diff -up"
end

# exa
if type -q exa
  alias ls="exa"
  alias ll="exa -lh -s date -s new --git"
  alias tree="exa -T"
end

# diff-so-fancy
if type -q diff-so-fancy
  alias dsf="diff-so-fancy"
end

# launch

# company settings (on WSL2)
# path
set -x PATH /mnt/d/bin $PATH
# aws-vault
set -x AWS_VAULT_BACKEND pass
set -x AWS_VAULT_PASS_PREFIX aws-vault

if not set -q INSIDE_GENIE
  exec genie -s
end

# tmux
if status is-interactive
and not set -q TMUX
    exec tmux
end
