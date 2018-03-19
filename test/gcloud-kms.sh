#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test 'Should exit with non-zero status when action param is not given' {
  run ./gcloud-kms.sh
  [[ "$status" != 0 ]]
}

@test 'Should exit with non-zero status when global param is not given' {
  run ./gcloud-kms.sh encrypt
  [[ "$status" != 0 ]]
}

@test 'Should exit with non-zero status when keyring param is not given' {
  run ./gcloud-kms.sh encrypt global
  [[ "$status" != 0 ]]
}

@test 'Should exit with non-zero status when key param is not given' {
  run ./gcloud-kms.sh encrypt global keyring
  [[ "$status" != 0 ]]
}

@test 'Should exit with non-zero status when file param is not given' {
  run ./gcloud-kms.sh encrypt global keyring key
  [[ "$status" != 0 ]]
}

@test 'Should exit with non-zero status when CREDENTIALS is not set' {
  run ./gcloud-kms.sh encrypt global keyring key test/fixtures/decrypted.txt
  [[ "$status" != 0 ]]
}

@test 'Should exit with non-zero status when CREDENTIALS file does not exist' {
  run CREDENTIALS=credentials.json ./gcloud-kms.sh encrypt global keyring key test/fixtures/decrypt
  [[ "$status" != 0 ]]
}
