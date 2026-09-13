#!/usr/local/bin bats
basedir=$BATS_TEST_DIRNAME
script="$basedir/../install.sh"

@test "All setup process should be executed successfully" {
  run "$script"
  [ "${status}" -eq 0 ]
}
