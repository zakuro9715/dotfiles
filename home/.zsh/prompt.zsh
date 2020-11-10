black=235
yellow=222
green=78
green_fg=159
blue=75
red=204
CURRENT_BG='NONE'
PRIMARY_FG="$black"

# Characters
SEGMENT_SEPARATOR=" " #"\u25B6" #"\ue0b0"
GEAR="⚙" #"\u2699"

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Git: branch/detached head, dirty status
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color_bg=$yellow
      color_fg=$black
    else
      color_bg=$green
      color_fg=$black
    fi
    if [[ "${ref/.../}" != "$ref" ]]; then
      ref="${ref/.../}"
    fi
    prompt_segment $color_bg $color_fg
    print -Pn " $ref "
  fi
}
  echo $RETVAL

# Dir: current working directory
prompt_dir() {
  dir=$([[ -n "$SHORT_PROMPT" ]] && echo '%C' || echo '%~')
  prompt_segment "%(?.$blue.$red)" $PRIMARY_FG " $dir "
}
#Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`
  prompt_segment "" "" "$user "
}

# Python venv
prompt_venv() {
  local venv=`(basename "$VIRTUAL_ENV")`
  [[ -n "$venv" ]] && prompt_segment cyan $PRIMARY_FG " $venv "
}

## Main prompt
prompt_zakuro_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_context
  prompt_dir
  prompt_venv
  prompt_git
  prompt_end
}

prompt_zakuro_precmd() {
  vcs_info
  PROMPT="\
╭─ %{%f%b%k%}$(prompt_zakuro_main)
╰─ > "
}

prompt_zakuro_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_zakuro_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_zakuro_setup "$@"
