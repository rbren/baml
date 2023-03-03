#! /bin/bash
function baml() {
  echo "${1}" | yq e "${2}" -
}
function bamlArr() {
  local -n result=$1
  result=()
  items=$(echo "${2}" | yq e -o=j -I=0 "${3} | .[]" -)
  while IFS= read -r item; do
    if [[ ${#item} -eq 0 ]]; then
      continue
    fi
    result+=("$(echo "${item}" | yq e -p json -o yaml '.' -)")
  done <<< "$items"
}
arr="
- 1
- 2
- 3
"

arrPlusOne=$(baml "${arr}" '.  | map(. + 1)')
echo ${arrPlusOne[@]}
bamlArr _tmp "${arr}" '.| map(. + 1)'
for num in "${_tmp[@]}"; do
  echo $(baml "${num}" '. ')
done
