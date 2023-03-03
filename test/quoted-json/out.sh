#! /bin/bash
function baml() {
  echo "${1}" | yq e "${2}" -
}
function bamlArr() {
  local -n result=$1
  result=()
  items=$(echo "${2}" | yq e -o=j -I=0 "${3}[]" -)
  while IFS= read -r item; do
    result+=("$(echo "${item}" | yq e -p json -o yaml '.' -)")
  done <<< "$items"
}
repositories='[{
  "full_name": "stackstorm",
  "stargazers_count": 3,
  "description": "StackStorm (aka \"IFTTT for Ops\") is event-driven automation"
}]'

bamlArr _tmp "${repositories}" '.'
for repo in "${_tmp[@]}"; do
  echo $(baml "${repo}" '.full_name') has $(baml "${repo}" '.stargazers_count') stargazers
done

