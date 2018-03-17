#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test 'Should output 1 if 1st version is greater than 2nd version' {
  assert_equal $(./version-compare.sh 1.0.0 1.0.0-rc.0) 1
}

@test 'Should output 0 if 1st version is equal to 2nd version' {
  assert_equal $(./version-compare.sh 1.0.0 1.0.0) 0
}

@test 'Should output -1 if 1st version is lower than 2nd version' {
  assert_equal $(./version-compare.sh 0.100.0 1.0.0) -1
}

@test 'Should output correct result if only 1 of the versions is prefixed with v' {
  assert_equal $(./version-compare.sh 0.100.0 v1.0.0) -1
}
