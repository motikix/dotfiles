# theme
set -x FOREGROUND_COLOR '#c5cdd9'
set -x BACKGROUND_COLOR '#2c2e34'
set -x BLACK_COLOR '#3e4249'
set -x RED_COLOR '#ec7279'
set -x GREEN_COLOR '#a0c980'
set -x YELLOW_COLOR '#deb974'
set -x BLUE_COLOR '#6cb6eb'
set -x MAGENTA_COLOR '#d38aea'
set -x CYAN_COLOR '#5dbbc1'
set -x WHITE_COLOR '#c5cdd9'

# environments

# backends
set -x GDK_BACKEND x11

# lang
set -x LANG en_US.UTF-8

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
source $HOME/.asdf/asdf.fish

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

# starship
if type -q starship
  starship init fish | source
end

# tmux
if status is-interactive
and not set -q TMUX
    exec tmux
end
