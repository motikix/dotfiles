# suppress greeting message
set fish_greeting

# environments

## lang
set -x LANG en_US.UTF-8

## gpg
set -x GPG_TTY (tty)

## editor
set -x EDITOR vim

# xdg base directory specification
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

## bin
set -x PATH $HOME/.local/bin $PATH

## asdf
if test -d $HOME/.asdf
  source $HOME/.asdf/asdf.fish
end

## java
if test "$XDG_SESSION_DESKTOP" = "sway"
  set -x _JAVA_AWT_WM_NONREPARENTING 1
end

## go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

## rust
set -x PATH $HOME/.cargo/bin $PATH

## haskell
set -x PATH $HOME/.cabal/bin $PATH
set -x PATH $HOME/.ghcup/bin $PATH

## node
set -x NPM_CONFIG_PREFIX $HOME/.local
set -x ESLINT_D_LOCAL_ESLINT_ONLY true
set -x PRETTIERD_LOCAL_PRETTIER_ONLY true

## deno
set -x DENO_INSTALL_ROOT $HOME/.local

## python
set -x PIPENV_VENV_IN_PROJECT true

## flutter
set -x PATH $HOME/flutter/bin $PATH

## fzf
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_ENABLE_OPEN_PREVIEW 1
set -x FZF_PREVIEW_FILE_CMD 'bat --color=always --style=numbers'
set -x FZF_PREVIEW_DIR_CMD 'exa -l'
set -x FZF_DEFAULT_COMMAND 'fd --hidden --follow --exclude .git'
set -x FZF_FIND_FILE_COMMAND "$FZF_DEFAULT_COMMAND --type f . \$dir"
set -x FZF_CD_COMMAND "$FZF_DEFAULT_COMMAND --type d --no-hidden . \$dir"
set -x FZF_CD_WITH_HIDDEN_COMMAND "$FZF_DEFAULT_COMMAND --type d . \$dir"
set -x FZF_OPEN_COMMAND "$FZF_DEFAULT_COMMAND --type f --type d . \$dir"
set -x FZF_DEFAULT_OPTS "\
  --height 40% --layout=reverse --border --bind ctrl-u:preview-up,ctrl-d:preview-down \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
set -x FZF_FIND_FILE_OPTS "--preview '$FZF_PREVIEW_FILE_CMD {}'"
set -x FZF_CD_OPTS "--preview '$FZF_PREVIEW_DIR_CMD {}'"

## ghq
set -x GHQ_SELECTOR_OPTS --preview "$FZF_PREVIEW_DIR_CMD {}"

## wakatime
set -x WAKATIME_HOME $HOME/.local/share/wakatime

# aliases

## neovim
if type -q nvim
  alias vim "nvim"
  alias vi "nvim -u NONE -c 'syntax on' -c 'se nu'"
end

## colordiff
if type -q colordiff
  alias diff "colordiff -up"
else
  alias diff "diff -up"
end

## exa
if type -q exa
  alias ls "exa --icons"
  alias ll "exa -lh --git --icons"
  alias tree "exa -T --icons"
end

## diff-so-fancy
if type -q diff-so-fancy
  alias dsf "diff-so-fancy"
end

# setup

## zoxide
if type -q zoxide
  set -x _ZO_FZF_OPTS $FZF_DEFAULT_OPTS "--preview '$FZF_PREVIEW_DIR_CMD {2..}'"
  zoxide init fish | source
end

# launch

## tmux
if status is-interactive; and not set -q TMUX
  exec tmux
end
