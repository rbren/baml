list="
pets:
- Goldie
- Rover
"

for pet in @{list.pets}; do
  echo %{pet}
done
