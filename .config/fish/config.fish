# theme (GitHub Dimmed)
set -x BACKGROUND_COLOR '#22272e'
set -x FOREGROUND_COLOR '#768390'
set -x BLACK_COLOR '#22272e'
set -x RED_COLOR '#ff938a'
set -x GREEN_COLOR '#6bc46d'
set -x YELLOW_COLOR '#c69026'
set -x BLUE_COLOR '#6cb6ff'
set -x MAGENTA_COLOR '#b083f0'
set -x CYAN_COLOR '#56d4dd'
set -x WHITE_COLOR '#768390'
set -x BRIGHT_BLACK_COLOR '#636e7b'
set -x BRIGHT_RED_COLOR '#ff938a'
set -x BRIGHT_GREEN_COLOR '#6bc46d'
set -x BRIGHT_YELLOW_COLOR '#daaa3f'
set -x BRIGHT_BLUE_COLOR '#6cb6ff'
set -x BRIGHT_MAGENTA_COLOR '#dcbdfb'
set -x BRIGHT_CYAN_COLOR '#56d4dd'
set -x BRIGHT_WHITE_COLOR '#768390'

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
# nodejs
set -x NODE_TLS_REJECT_UNAUTHORIZED 0

if not set -q INSIDE_GENIE
  exec genie -s
end

# starship
if type -q starship
  starship init fish | source
end

# tmux
if status is-interactive
and not set -q TMUX
    exec tmux
end
