#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test 'Should output nothing when the address is a valid one' {
  ./wait-for-it.sh -address=https://google.com -timeout=1
}

@test 'Should exit with non-zero status and output "no such host" when the address is not a valid one' {
  run ./wait-for-it.sh -address=https://test123.test123 -timeout=1
  [[ "$status" != 0 ]]
  [[ "$output" =~ "no such host" ]]
}
