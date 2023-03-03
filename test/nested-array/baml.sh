list="
pets:
- name: Goldie
  nicknames:
  - Gogo
- name: Rover
"

echo %{list.pets[0].nicknames[0]}

for pet in @{list.pets}; do
  # FIXME: Rover gets a nickname printed too...
  for nickname in @{pet.nicknames}; do
    echo %{pet.name} has nickname %{nickname}
  done
done


list="
- - foo
  - bar
- - quux
  - baz
"

for arr in @{list}; do
  for item in @{arr}; do
    echo %{item}
  done
done

