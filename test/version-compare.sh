#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test 'Should output 1 if 1st version is greater than 2nd version' {
  assert_equal $(./version-compare.sh 10.0.0 1.0.0) 1
  assert_equal $(./version-compare.sh 0.10.0 0.9.0) 1
  assert_equal $(./version-compare.sh 0.0.10 0.0.1) 1
  assert_equal $(./version-compare.sh 2.16.0 2.9.0) 1
}

@test 'Should output 0 if 1st version is equal to 2nd version' {
  assert_equal $(./version-compare.sh 1.0.0 1.0.0) 0
  assert_equal $(./version-compare.sh 0.1.0 0.1.0) 0
  assert_equal $(./version-compare.sh 0.0.1 0.0.1) 0
  assert_equal $(./version-compare.sh 2.16.0 2.16.0) 0
}

@test 'Should output -1 if 1st version is lower than 2nd version' {
  assert_equal $(./version-compare.sh 1.0.0 10.0.0) -1
  assert_equal $(./version-compare.sh 0.1.0 0.10.0) -1
  assert_equal $(./version-compare.sh 0.0.1 0.0.10) -1
  assert_equal $(./version-compare.sh 2.9.0 2.16.0) -1
}
