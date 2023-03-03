list="
pets:
- name: Goldie
- name: Rover
"

for pet in @{list.pets}; do
  echo %{pet.name}
done
