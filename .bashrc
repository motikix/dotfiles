# ----- environments -----

# Lang
export LANG=en_US.UTF-8

# Editor
export EDITOR=vim

# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# homebrew
export PATH=/usr/local/sbin:$PATH

# binutils
export PATH=/usr/local/opt/binutils/bin:$PATH

# anyenv
eval $(anyenv init -)

# haskell
export PATH=$HOME/.local/bin:$PATH

# clangd
export PATH=/usr/local/opt/llvm/bin:$PATH

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# rust
export PATH=$HOME/.cargo/bin:$PATH

# java
export JAVA_HOME=$(/usr/libexec/java_home -v "13")
export PATH=$JAVA_HOME/bin:$PATH

# v
export PATH=$HOME/.ghq/github.com/vlang/v:$PATH

# python
export PIPENV_VENV_IN_PROJECT=true

# ocaml
export OPAM_SWITCH_PREFIX=$HOME/.opam/default
export CAML_LD_LIBRARY_PATH=$HOME/.opam/default/lib/stublibs:Updated by package ocaml
export OCAML_TOPLEVEL_PATH=$HOME/.opam/default/lib/toplevel
export PATH=$HOME/.opam/default/bin:$PATH

# fzf
export FZF_LEGACY_KEYBINDINGS=1
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "head -n 30 {}"'

# flutter
export PATH=$HOME/flutter/bin:$PATH

# ----- aliases -----

# neovim
if [[ -x `which nvim` ]]; then
  alias vim='nvim'
fi

# diff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# exa
if [[ -x `which exa` ]]; then
  alias ls='exa'
  alias ll='exa -lha -s date -s new --git'
  alias tree='exa -T'
fi

# lazygit
if [[ -x `which lazygit` ]]; then
  alias lgit='lazygit'
fi

# lazydocker
if [[ -x `which lazydocker` ]]; then
  alias ldocker='lazydocker'
fi

# ----- execution -----
if [ $SHLVL = 1 ]; then
  exec tmux
fi
