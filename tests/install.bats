#!/usr/local/bin bats
basedir=$BATS_TEST_DIRNAME

zakuro="$HOME/src/github.com/zakuro9715"
dotfiles="$zakuro/dotfiles"
script="$basedir/../install.sh"

bootstrap_mock=""
bootstrap_mock_text="bootstrap mock called"

setup() {
  bootstrap_mock="$(mktemp)"
  chmod +x "$bootstrap_mock"
  echo "echo $bootstrap_mock_text" > "$bootstrap_mock"
}

teardown() {
  rm -f "$bootstrap_mock"
}

@test "Exists '$dotfiles'" {
  run "$script" "$bootstrap_mock"
  echo "$output"
  [ "${status}" -eq 0 ]
  [ "${lines[-1]}" = "$bootstrap_mock_text" ]
}
