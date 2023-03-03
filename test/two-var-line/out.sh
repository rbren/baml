#! /bin/bash

function baml() {
  echo "${1}" | yq eval "${2}" -
}

function bamlArr() {
  local -n result=$1
  result=$(baml "${2}" "${3}[]")
}
person="
name: Jane
age: 23
"

echo $(baml "${person}" '.name') is $(baml "${person}" '.age') years old
