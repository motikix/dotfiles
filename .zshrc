# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

#--------------------------------------------------------------------#
#                            environments                            #
#--------------------------------------------------------------------#

# lang
export LANG=en_US.UTF-8

# xdg
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# bin
export PATH=$HOME/.local/bin:$PATH

# gpg
export GPG_TTY=$(tty)

# fzf
export FZF_LEGACY_KEYBINDINGS=0
export FZF_ENABLE_OPEN_PREVIEW=1
export FZF_PREVIEW_FILE_CMD='bat --color=always --style=numbers'
export FZF_PREVIEW_DIR_CMD='exa -l'
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_FIND_FILE_COMMAND="$FZF_DEFAULT_COMMAND --type f . \$dir"
export FZF_CD_COMMAND="$FZF_DEFAULT_COMMAND --type d --no-hidden . \$dir"
export FZF_CD_WITH_HIDDEN_COMMAND="$FZF_DEFAULT_COMMAND --type d . \$dir"
export FZF_OPEN_COMMAND="$FZF_DEFAULT_COMMAND --type f --type d . \$dir"
export FZF_DEFAULT_OPTS="\
  --height 40% --layout=reverse --border --bind ctrl-u:preview-up,ctrl-d:preview-down \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_FIND_FILE_OPTS="--preview '$FZF_PREVIEW_FILE_CMD {}'"
export FZF_CD_OPTS="--preview '$FZF_PREVIEW_DIR_CMD {}'"

# go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# rust
export PATH=$HOME/.cargo/bin:$PATH

# python
export PIPENV_VENV_IN_PROJECT=true

#--------------------------------------------------------------------#
#                             functions                              #
#--------------------------------------------------------------------#

function _exists_cmd() { type "$1" > /dev/null 2>&1; }

function _fzf_ghq() {
  local query=$([[ -n $BUFFER ]] && echo $BUFFER || echo '')
  local root=$(ghq root)
  local repo=$(ghq list | fzf --query "$query" --preview "$FZF_PREVIEW_DIR_CMD $root/{}")
  if [[ -n $repo ]] then
    local dest=$root/$repo
    [[ -d $dest ]] && cd $dest
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N _fzf_ghq
bindkey "^g" _fzf_ghq

#--------------------------------------------------------------------#
#                              aliases                               #
#--------------------------------------------------------------------#

_exists_cmd nvim && {
  alias vim='nvim'
  alias vi='nvim -u NONE -c "syntax on" -c "se nu"'
}
_exists_cmd exa && {
  alias ls='exa --icons'
  alias ll='exa -lh --git --icons'
  alias tree='exa -T --icons'
}
_exists_cmd bat && alias cat='bat'

#--------------------------------------------------------------------#
#                               setup                                #
#--------------------------------------------------------------------#

if [[ -d $HOME/.asdf ]]; then
  . $HOME/.asdf/asdf.sh
  fpath=($ASDF_DIR/completions $fpath)
fi

_exists_cmd zoxide && {
  export _ZO_FZF_OPTS=($FZF_DEFAULT_OPTS "--preview '$FZF_PREVIEW_DIR_CMD {2..}'")
  eval "$(zoxide init zsh)"
}

_exists_cmd tmux && {
  [[ -z $TMUX ]] && [[ -z $VSCODE_PID ]] && [[ -z $VSCODE_INJECTION ]] && exec tmux
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#--------------------------------------------------------------------#
#                            zsh options                             #
#--------------------------------------------------------------------#

setopt ignore_eof

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

setopt magic_equal_subst

autoload -Uz compinit && compinit

autoload -Uz promptinit && promptinit
prompt pure

#--------------------------------------------------------------------#
#                               zinit                                #
#--------------------------------------------------------------------#

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light hlissner/zsh-autopair

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
