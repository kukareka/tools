#!/usr/bin/env bash


usage() {
  echo "
Encrypt/Decrypt a file using Google Cloud Platform KMS.

Usage:
./$(basename ${0}) <encrypt|decrypt> LOCATION KEYRING KEY FILE
"
}

while getopts ":" opt; do
  case $opt in
    \?)
      usage
      exit 1
      ;;
  esac
done

action=${1:-}
if [[ -z "$action" || ("$action" != "encrypt" && "$action" != "decrypt") ]]; then
  usage
  exit 1
fi

location=${2:-}
if [[ -z "$location" ]]; then
  usage
  exit 1
fi

keyring=${3:-}
if [[ -z "$keyring" ]]; then
  usage
  exit 1
fi

key=${4:-}
if [[ -z "$key" ]]; then
  usage
  exit 1
fi

file=${5:-}
if [[ -z "$file" ]]; then
  usage
  exit 1
fi

credentials=${CREDENTIALS:-}
if [[ -z "$credentials" ]]; then
  echo "CREDENTIALS environment variable is not configured."
  exit 1
fi

if [[ ! -f "$credentials" ]]; then
  echo "CREDENTIALS path does not exist."
  exit 1
fi

plaintext_file="$file"
if [[ "$action" == "encrypt" && ! -f "$plaintext_file" ]]; then
  echo "\"$plaintext_file\" does not exist."
  exit 1
fi

ciphertext_file="$plaintext_file"
if [[ ! ciphertext_file =~ .enc$ ]]; then
  ciphertext_file="$plaintext_file.enc"
fi

if [[ "$action" == "decrypt" && ! -f "$ciphertext_file" ]]; then
  echo "\"$ciphertext_file\" does not exist."
  exit 1
fi

project_id=$(cat $credentials | jq -r ".project_id")
if [[ -z "$project_id" ]]; then
  echo "Could not extract project ID from the credentials."
  exit 1
fi

gcloud auth activate-service-account --key-file=$credentials
gcloud config set project "$project_id"
gcloud kms "$action" --location=$location --keyring=$keyring --key=$key --plaintext-file=$plaintext_file --ciphertext-file=$ciphertext_file
