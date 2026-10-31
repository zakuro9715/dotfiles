_assert_print_help() {
  cat <<EOS
assert cmd [-- --flag1 value1 --flag2 value2 ...]
flags:
  output: omit flag name, it will be treated as --output
  --output "output": expect stdout and stderr combined
  --exit 1, --exit-code 1: expect exit code. By default, expect exit code 0

examples:
  assert cmd                                # cmd should exit with 0
  assert @title cmd                         # 1st argument strats with @, it will be treated as title
  assert cmd -- --stdout "output1 output2"  # should output "output1 output2" to stdout
  assert cmd -- --output output1 output2    # same as above but for stdout and stderr combined
  assert cmd -- output1 output2             # --output can be omitted
  assert cmd -- --exit 1                    # should exit with 1
  assert cmd -- --exit 1 --output "output"  # should exit with 1 and output "output"
  assert cmd -- --exit 1 output             # --output can be omitted
EOS
}

_is_help() {
  [[ "$1" == "--help" || "$1" == "-h" ]]
}

assert() {
  if _is_help "$1"
  then
    _assert_print_help
    return 0
  fi

  local title=""
  if [[ "$1" == @* ]]
  then
    title="${1#@}"
    shift
  fi

  local cmd=()
  while [ $# -gt 0 ]; do
    if [[ "$1" == "--" ]]; then
      shift  # '--' 自身を消費（捨てる）
      break  # ループを抜ける
    fi

    cmd+=("$1")
    shift
  done

  if [[ -z "$title" ]]; then
    title="${cmd[@]}"
  fi

  expected_exit_code=0
  expected_output=""
  no_expected_output=1
  while [ $# -gt 0 ];
  do
    if _is_help "$1"
    then
      _assert_print_help
      return 0
    fi

    case "$1" in
      --exit-code|--exit)
        shift
        if [[ "$1" == "=" ]]
        then
          shift
        fi
        if [[ "$1" == "" ]] || [[ "$1" == "--"* ]]; then
          print "Error: --exit-code requires a value" >&2
          return 1
        fi
        expected_exit_code="$1"
        ;;
      --output)
        shift
        ;& # fallthrough
      *)
        if [[ "$expected_output" != "" ]]; then
          print "Error: output can only be specified once" >&2
          return 1
        fi
        expected_output="$expected_output$1"
        no_expected_output=0
        ;;
    esac
    shift
  done

  output="$("${cmd[@]}" 2>&1)"
  exit_code=$?

  fail_exit_code=$(( $exit_code != $expected_exit_code ))
  fail_output="$( [[ "$output" != "$expected_output" ]] && echo "1" || echo "0" )"

  if ((no_expected_output))
  then
    fail_output=0
  fi

  if ((fail_exit_code || fail_output))
  then
    print "\e[31mFailed\e[0m: $title"
  else
    print "\e[32mPassed\e[0m: $title"
  fi
  if ((fail_exit_code))
  then
    print "Expected exit code: $expected_exit_code"
    print "Got exit code: $exit_code"
  fi
  if ((fail_output))
  then
#diff <(echo ${output}) <(echo ${expected_output})
    print "Expected output: $expected_output"
    print "Got output: $output"
  fi
}
