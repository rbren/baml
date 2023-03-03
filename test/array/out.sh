#! /bin/bash
function baml() {
  echo "${1}" | yq e "${2}" -
}
function bamlArr() {
  local -n result=$1
  result=()
  items=$(echo "${2}" | yq e -o=j -I=0 "${3}[]" -)
  while IFS= read -r item; do
    if [[ ${#item} -eq 0 ]]; then
      continue
    fi
    result+=("$(echo "${item}" | yq e -p json -o yaml '.' -)")
  done <<< "$items"
}
list="
pets:
- name: Goldie
- name: Rover
"

bamlArr _tmp "${list}" '.pets'
for pet in "${_tmp[@]}"; do
  echo $(baml "${pet}" '.name')
done

list="
- name: Goldie
- name: Rover
"

bamlArr _tmp "${list}" '.'
for pet in "${_tmp[@]}"; do
  echo $(baml "${pet}" '.name')
done

list="
- Goldie
- Rover
"

bamlArr _tmp "${list}" '.'
for pet in "${_tmp[@]}"; do
  echo $(baml "${pet}" '. ')
done
