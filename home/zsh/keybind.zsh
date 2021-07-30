# ^a   -> Ctrl+a
# ^[a  -> Alt+a
# ^[^a -> Ctrl+Alt+a
# ^A   -> Ctrl+Shift+a
# ^[A  -> Alt+Shift+a
# ^[^A -> Ctrl+Alt+Shift+a

# move by:
#    i
#   jkl
bindkey -r "^[i"
bindkey -s "^[i" "^[[A"
bindkey -r "^[k"
bindkey -s "^[k" "^[[B"
bindkey -r "^[l"
bindkey -s "^[l" "^[[C"
bindkey -r "^[j"
bindkey -s "^[j" "^[[D"


# Ctrl + Left
bindkey "^[[1;5D" beginning-of-line
bindkey -r "^[^j"
bindkey -s "^[^j" "^[[1;5D"

# Ctrl + Right
bindkey "^[[1;5C" end-of-line
bindkey -r "^[^l"
bindkey -s "^[^l" "^[[1;5C"

# Shift + Left
bindkey "^[[1;2D" backward-word
bindkey -r "^[J"
bindkey -s "^[J" "^[[1;2D"

# Shift + Right
bindkey "^[[1;2C" forward-word
bindkey -r "^[L"
bindkey -s "^[L" "^[[1;2C"
