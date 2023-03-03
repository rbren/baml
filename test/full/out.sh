#! /bin/bash

function baml() {
  echo "${1}" | yq e "${2}" -
}

function bamlArr() {
  local -n result=$1
  result=()
  items=$(echo "${2}" | yq e -o=j -I=0 "${3}[]" -)
  while IFS=\= read item; do
    result+=($(echo "${item}" | yq e -p json -o yaml '.' -))
  done <<EOL
  $items
EOL
}
person="
name: Jane Austen
age: 23
pets:
- Rover
- Goldie
"

  echo -e "${person}"

  echo $(baml "${person}" '.name')
# echo $(baml "${person}" ".name")

  echo $(baml "${person}" '.pets[0]')
# echo $(baml "${person}" ".pets[0]")

  echo $(baml "${person}" '.name | upcase')
# echo $(baml "${person}" ".name | upcase")

  firstName=$(baml "${person}" '.name | split(" ") | .[0] ')
# firstName=$(baml "${person}" '.name | split(" ") | .[0]')

  echo "first name: $firstName"

  if [[ $(baml "${person}" '.age') -gt 23 ]]; then
# if [[ $(baml "${person}" .age) -gt 23 ]]; then
    echo $(baml "${person}" '.name') can drink!
    # echo "$(baml "${person}" ".name") can drink!"
  fi
  if [[ $(baml "${person}" '.pets[0]') == "Rover" ]]; then
# if [[ $(baml "${person}" ".pets[0]") == "Rover" ]]; then
    echo "it's rover!"
  fi

  if [[ $(baml "${person}" '.pets | length') -gt 1 ]]; then
# if [[ $(baml "${person}" ".pets | length" -gt 1) ]]; then
    echo "more than one pet!"
  fi

bamlArr _tmp "${person}" '.pets'
  for pet in ${_tmp[@]}; do
# bamlArr pets "${person}" ".pets"
# for pet in ${pets[@]}; do
  echo "Pet: $pet"
done

