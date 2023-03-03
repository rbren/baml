#! /bin/bash

function baml() {
  echo "${1}" | yq e "${2}" -
}

function bamlArr() {
  local -n result=$1
  result=()
  items=$(echo "${2}" | yq e -o=j -I=0 "${3}[]" -)
  while IFS=\= read item; do
    result+=("$(echo "${item}" | yq e -p json -o yaml '.' -)")
  done <<EOL
  $items
EOL
}
name="Jane"
echo "your name is $(baml "${name}" '. ')"
echo "your name in uppercase is $(baml "${name}" '.  | upcase')"

pets="
- Goldie
- Rover
"

bamlArr _tmp "${pets}" '.'
for pet in "${_tmp[@]}"; do
  echo $pet
done

