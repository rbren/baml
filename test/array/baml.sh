list="
pets:
- name: Goldie
- name: Rover
"

for pet in @{list.pets}; do
  echo %{pet.name}
done

list="
- name: Goldie
- name: Rover
"

for pet in @{list}; do
  echo %{pet.name}
done

list="
- Goldie
- Rover
"

for pet in @{list}; do
  echo %{pet}
done
