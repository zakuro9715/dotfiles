autoload -Uz vcs_info

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:*' formats '%r' '%S' '%b' '%c' '%u'
zstyle ':vcs_info:*' actionformats '%b|%a' '$s' '%c' '%u'

prompt() {
  local branch repo_dir untracked unstaged staged
  vcs_repo_name="$vcs_info_msg_0_"
  vcs_pwd="$vcs_info_msg_1_"
  vcs_branch="$vcs_info_msg_2_"
  vcs_untracked="$(git status 2> /dev/null | grep "^Untracked")"
  vcs_unstaged="$vcs_info_msg_3_"
  vcs_staged="$vcs_info_msg_4_"

  # $vcs_pwd is '.' if $PWD is /path/to/repo.
  # And result of concating $vcs_repo_name and $vcs_pwd is 'repo/.'.
  # But I want it to be 'repo'.
  if [[ $vcs_pwd = '.' ]]; then
    vcs_pwd=''
  fi


  local happy unhappy kao stcolor color symbol text

  color='%(?.blue.red)'
  symbol='%(!.#.$)'

  happy='(._.%)'
  unhappy='(;_;%)'
  if [[ $VIRTUAL_ENV ]]; then
    happy='(._.%)'
    unhappy='(>_<%)'
    text=`basename $VIRTUAL_ENV`
  fi
  kao="%(?#$happy#$unhappy)"

  PROMPT="%B%K{$color}$kao%k%b "
  if [[ $text ]] then
    PROMPT="$PROMPT($text) "
  fi
  if [[ $vcs_untracked || $vcs_unstaged || $vcs_staged ]] then
    PROMPT="$PROMPT%F{yellow}%Bx%b%f "
  fi


  local pos vcs="[$vcs_branch]%f "
  if [[ $vcs_staged ]]; then
    vcs="%F{blue}$vcs"
  fi
  if [[ $vcs_unstaged || $vcs_untracked ]]; then
    vcs="%F{red}$vcs"
  fi

  if [[ $vcs_repo_name ]]; then # In a vcs directory
    pos="$vcs_repo_name/$vcs_pwd"
    pos="${pos%/}" # Remove a tail '/'
  else
    pos='%1d'
    vcs=''
  fi

  RPROMPT="$vcs%F{yellow}[$pos]%f"
}
