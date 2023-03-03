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
