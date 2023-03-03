#! /bin/bash

function baml() {
  echo "${1}" | yq eval "${2}" -
}

function bamlArr() {
  local -n result=$1
  result=$(baml "${2}" "${3}[]")
}
name="Jane"
echo "your name is $(baml "${nam}" 'e')"
echo "your name in uppercase is $(baml "${name}" ' | upcase')"

