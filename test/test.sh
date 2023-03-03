#! /bin/bash

some_changed=0
for dir in ./test/*; do
  if [[ $dir == "./test/test.sh" ]]; then
    continue
  fi
  echo $dir
  BAML_FILE=$dir/baml.sh ./transpile.sh > $dir/out.sh
  if ! git diff --quiet --exit-code $dir; then
    echo "test $dir changed"
    some_changed=1
  fi
done

if [[ $some_changed -eq 1 ]]; then
  echo "Some tests changed!"
  exit 1
fi
