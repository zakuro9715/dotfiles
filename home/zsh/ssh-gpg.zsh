function pubkey() {
  cat ~/.ssh/*.pub
}

gpg_keyid="42958771DD3E13B5F8F74E1DAA579A0BDF319A87"
function gpg-export() {
  gpg --armor --export "$gpg_keyid"
}

function gpg-export-secret() {
  gpg --armor --export-secret-keys "$gpg_keyid"
}

function gpg-export-to() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    print "'$dir' is not a directory or does not exist."
    exit 1
  fi
  gpg-export > $1/key.pub
  gpg-export-secret > $1/key.sec
}

function gpg-import() {
  gpg --import $1
}

function gpg-import-from() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    print "'$dir' is not a directory or does not exist."
    exit 1
  fi
  gpg-import $1/key.pub
  gpg-import $1/key.sec
}
