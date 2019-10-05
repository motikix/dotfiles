# fish
set -x theme_color_scheme 'dark'

# aliases
# colordiff
if test -x (which colordiff)
  alias diff="colordiff -u"
else
  alias diff="diff -u"
end

# exa
if test -x (which exa)
  alias ls="exa"
  alias ll="exa -lh -s date -s new --git"
  alias tree="exa -T"
end

# starship
eval (starship init fish)
