#!/usr/local/bin bats
basedir=$BATS_TEST_DIRNAME

zakuro="$HOME/src/github.com/zakuro9715"
dotfiles="$zakuro/dotfiles"
script="$basedir/../install.sh"

bootstrap_mock=""
bootstrap_mock_text="bootstrap mock called"

setup() {
  bats_require_minimum_version 1.5.0

  bootstrap_mock="$(mktemp)"
  chmod +x "$bootstrap_mock"
  echo "echo $bootstrap_mock_text" > "$bootstrap_mock"
}

teardown() {
  rm -f "$bootstrap_mock"
}

@test "Exists '$dotfiles'" {
  run -0 "$script" "$bootstrap_mock"
  [ "${lines[-1]}" = "$bootstrap_mock_text" ]

  run -0 which zsh
  run -0 which git
}
