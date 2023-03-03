#! /bin/bash

{(
cat <<EOF
#! /bin/bash

function baml() {
  echo "\${1}" | yq eval "\${2}" -
}

function bamlArr() {
  local -n result=\$1
  result=\$(baml "\${2}" "\${3}[]")
}
EOF
) ; cat $1; } \
  | sed -e 's/%{\s*\([[:alnum:]]\+\)\(.*\)\s*}/$(baml "${\1}" '"'\2'"')/g' \
  | sed -e 's/^\(.*\)@{\s*\([[:alnum:]]\+\)\(.*\)\s*}\(.*\)$/$(bamlArr _tmp "${\2}" '"'\3'"')\n\1${_tmp[@]}\4/g' \
  | /bin/bash
