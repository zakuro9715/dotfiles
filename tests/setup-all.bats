#!/usr/local/bin bats
basedir=$BATS_TEST_DIRNAME
script="$basedir/../install.sh"

setup() {
  bats_require_minimum_version 1.5.0
}

@test "All setup process should be executed successfully" {
  run -0 "$script"

  run -0 which zsh
  run -0 which go
  run -0 which npm
}
