source ./testing.zsh
echo_ret1() {
  echo "$@"
  return 1
}

run(){
  # pass
  assert echo 'Hello'
  assert echo 'Hello'      -- 'Hello'
  assert echo 'Hello'      -- --output 'Hello'
  assert echo_ret1 'Hello' -- 'Hello' --exit-code 1
  assert echo_ret1 'Hello' -- 'Hello' --exit 1

  # fail
  assert echo_ret1 'Hello'
  assert echo 'Hello'      -- 'World'
  assert echo 'Hello'      -- --output 'World'
  assert echo 'Hello'      -- 'Hello' --exit-code 1
}

Failed="\e[31mFailed\e[0m"
Passed="\e[32mPassed\e[0m"
expected="$Passed: echo Hello
$Passed: echo Hello
$Passed: echo Hello
$Passed: echo_ret1 Hello
$Passed: echo_ret1 Hello
$Failed: echo_ret1 Hello
Expected exit code: 0
Got exit code: 1
$Failed: echo Hello
Expected output: World
Got output: Hello
$Failed: echo Hello
Expected output: World
Got output: Hello
$Failed: echo Hello
Expected exit code: 1
Got exit code: 0"

[[ "$(run)" == "$(echo "$expected")" ]] && echo $Passed || echo $Failed
