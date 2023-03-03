arr="
- 1
- 2
- 3
"

arrPlusOne=%{arr | map(. + 1)}
echo ${arrPlusOne[@]}
for num in @{arr | map(. + 1)}; do
  echo %{num}
done

# FIXME: is this a yq issue? select doesn't output YAML
# https://github.com/mikefarah/yq/issues/1586
big=%{arr.[] | select(. > 1) | .[] }
echo ${big[@]}
for num in @{big.[] | select(. > 1) | .[] }; do
  echo %{num}
done
