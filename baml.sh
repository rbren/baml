#! /bin/bash

function baml() {
  echo "${1}" | yq eval "${2}" -
}

function bamlArr() {
  local -n result=$1
  result=$(baml "${2}" "${3}[]")
}

person="
name: Jane Austen
age: 23
pets:
- Rover
- Goldie
"

echo -e "${person}"

# shorthand: echo %{person.name}
echo "$(baml "${person}" .name)"
# shorthand: echo %{person.pets[0]}
echo "$(baml "${person}" ".pets[0]")"

# shorthand: echo %{person.name | upcase}
echo "$(baml "${person}" ".name | upcase")"

# shorthand: firstName=%{person.name | split(" ")}
firstName=$(baml "${person}" '.name | split(" ") | .[0]')
echo "first name: $firstName"

# shorthand: if [[ %{person.age} -gt 23 ]]; then
if [[ $(baml "${person}" .age) -gt 23 ]]; then
  echo "$(baml "${person}" .name) can drink!"
fi
# shorthand: if [[ %{person.pets[0]} == "Rover" ]]; then
if [[ $(baml "${person}" ".pets[0]") == "Rover" ]]; then
  echo "it's rover!"
fi
# shorthand: if [[ %{person.pets | length} -gt 1 ]]; then
if [[ $(baml "${person}" ".pets | length" -gt 1) ]]; then
  echo "more than one pet!"
fi

# shorthand: for pet in @{person.pets}
bamlArr pets "${person}" .pets
for pet in ${pets[@]}; do
  echo "Pet: $pet"
done

