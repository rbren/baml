#! /bin/bash

for dir in ./test/*; do
  echo $dir
  BAML_FILE=$dir/baml.sh ./transpile.sh > $dir/out.sh
  if ! git diff --quiet --exit-code $dir; then
    echo "test $dir changed"
  fi
done

if ! git diff --quiet --exit-code ./test; then
  echo "Some tests changed!"
  exit 1
fi
