{(
cat <<EOF
#! /bin/bash
function baml() {
  echo "\${1}" | yq e "\${2}" -
}
function bamlArr() {
  local -n result=\$1
  result=()
  items=\$(echo "\${2}" | yq e -o=j -I=0 "\${3} | .[]" -)
  while IFS= read -r item; do
    if [[ \${#item} -eq 0 ]]; then
      continue
    fi
    result+=("\$(echo "\${item}" | yq e -p json -o yaml '.' -)")
  done <<< "\$items"
}
EOF
) ; cat $BAML_FILE; } \
  | grep -v "#no_baml" \
  | sed -e 's/%{\s*\([[:alnum:]]\+\)\(\.[^}]*\)\s*}/$(baml "${\1}" '"'\2'"')/g' \
  | sed -e 's/%{\s*\([[:alnum:]]\+\)\([^}]*\)\s*}/$(baml "${\1}" '"'. \2'"')/g' \
  | sed -e 's/^\(.*\)@{\s*\([[:alnum:]]\+\)\(\.[^}]*\)\s*}\(.*\)$/bamlArr _tmp "${\2}" '"'\3'"'\n\1"${_tmp[@]}"\4/g' \
  | sed -e 's/^\(.*\)@{\s*\([[:alnum:]]\+\)\s*\([^}]*\)\s*}\(.*\)$/bamlArr _tmp "${\2}" '"'.\3'"'\n\1"${_tmp[@]}"\4/g'
