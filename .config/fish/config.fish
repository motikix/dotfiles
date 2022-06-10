# suppress greeting message
set fish_greeting

# theme (Material Ocean)
set -x BACKGROUND_COLOR '#0f111a'
set -x FOREGROUND_COLOR '#a6accd'
set -x BLACK_COLOR '#000000'
set -x RED_COLOR '#f07178'
set -x GREEN_COLOR '#c3e88d'
set -x YELLOW_COLOR '#ffcb6b'
set -x BLUE_COLOR '#82aaff'
set -x MAGENTA_COLOR '#bb80b3'
set -x CYAN_COLOR '#89ddff'
set -x WHITE_COLOR '#ffffff'
set -x BRIGHT_BLACK_COLOR '#464b5d'
set -x BRIGHT_RED_COLOR '#f07178'
set -x BRIGHT_GREEN_COLOR '#c3e88d'
set -x BRIGHT_YELLOW_COLOR '#ffcb6b'
set -x BRIGHT_BLUE_COLOR '#82aaff'
set -x BRIGHT_MAGENTA_COLOR '#bb80b3'
set -x BRIGHT_CYAN_COLOR '#89ddff'
set -x BRIGHT_WHITE_COLOR '#ffffff'

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
set -x FZF_COMPLETE 1
set -x FZF_ENABLE_OPEN_PREVIEW 1
set -x FZF_PREVIEW_FILE_CMD 'bat --color=always --style=numbers'
set -x FZF_PREVIEW_DIR_CMD 'exa -l'
set -x FZF_DEFAULT_COMMAND 'fd --hidden --follow --exclude .git'
set -x FZF_FIND_FILE_COMMAND "$FZF_DEFAULT_COMMAND --type f . \$dir"
set -x FZF_CD_COMMAND "$FZF_DEFAULT_COMMAND --type d --no-hidden . \$dir"
set -x FZF_CD_WITH_HIDDEN_COMMAND "$FZF_DEFAULT_COMMAND --type d . \$dir"
set -x FZF_OPEN_COMMAND "$FZF_DEFAULT_COMMAND --type f --type d . \$dir"
set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --bind ctrl-u:preview-up,ctrl-d:preview-down'
set -x FZF_FIND_FILE_OPTS "--preview '$FZF_PREVIEW_FILE_CMD {}'"
set -x FZF_CD_OPTS "--preview '$FZF_PREVIEW_DIR_CMD {}'"

## ghq
set -x GHQ_SELECTOR_OPTS --preview "$FZF_PREVIEW_DIR_CMD {}"

## wakatime
set -x WAKATIME_HOME $HOME/.local/share/wakatime

# aliases

## neovim
if type -q nvim
  alias vim="nvim"
  alias vi="nvim -u NONE -c 'syntax on' -c 'se nu'"
end

## colordiff
if type -q colordiff
  alias diff="colordiff -up"
else
  alias diff="diff -up"
end

## exa
if type -q exa
  alias ls="exa --icons"
  alias ll="exa -lh --git --icons"
  alias tree="exa -T --icons"
end

## diff-so-fancy
if type -q diff-so-fancy
  alias dsf="diff-so-fancy"
end

# key binds

## fzf
### overwrite https://github.com/jorgebucaran/autopair.fish/blob/main/conf.d/autopair.fish#L18
bind \t '__fzf_complete'

# launch

## starship
if type -q starship
  starship init fish | source
end

## tmux
if status is-interactive; and not set -q TMUX
  exec tmux
end
