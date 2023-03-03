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
  nicknames:
  - Gogo
- name: Rover
"

echo $(baml "${list}" '.pets[0].nicknames[0]')

bamlArr _tmp "${list}" '.pets'
for pet in "${_tmp[@]}"; do
bamlArr _tmp "${pet}" '.nicknames'
  for nickname in "${_tmp[@]}"; do
    echo $(baml "${pet}" '.name') has nickname $(baml "${nickname}" '. ')
  done
done


list="
- - foo
  - bar
- - quux
  - baz
"

bamlArr _tmp "${list}" '.'
for arr in "${_tmp[@]}"; do
bamlArr _tmp "${arr}" '.'
  for item in "${_tmp[@]}"; do
    echo $(baml "${item}" '. ')
  done
done

