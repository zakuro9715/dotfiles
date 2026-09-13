#!/usr/bin/env bats

root=$BATS_TEST_DIRNAME/..
home=$root/home

find_ext() {
  find $root -type f -name "*.$1"
}

exclude() {
  grep -v $@
}


@test "shellcheck is installed" {
  run shellcheck --version
  [ "$status" -eq 0 ]
}

@test "shellcheck .sh files" {
  tmux=$home/tmux
  files="$(find_ext sh | exclude $tmux)"
  for file in $files; do
    run shellcheck "$file"
    [ "$status" -eq 0 ]
  done
}
