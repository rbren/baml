person="
name: Jane Austen
age: 23
pets:
- Rover
- Goldie
"

  echo -e "${person}"

  echo %{person.name}
# echo $(baml "${person}" ".name")

  echo %{person.pets[0]}
# echo $(baml "${person}" ".pets[0]")

  echo %{person.name | upcase}
# echo $(baml "${person}" ".name | upcase")

  firstName=%{ person.name | split(" ") | .[0] }
# firstName=$(baml "${person}" '.name | split(" ") | .[0]')

  echo "first name: $firstName"

  if [[ %{person.age} -gt 23 ]]; then
# if [[ $(baml "${person}" .age) -gt 23 ]]; then
    echo %{person.name} can drink!
    # echo "$(baml "${person}" ".name") can drink!"
  fi
  if [[ %{person.pets[0]} == "Rover" ]]; then
# if [[ $(baml "${person}" ".pets[0]") == "Rover" ]]; then
    echo "it's rover!"
  fi

  if [[ %{person.pets | length} -gt 1 ]]; then
# if [[ $(baml "${person}" ".pets | length" -gt 1) ]]; then
    echo "more than one pet!"
  fi

  for pet in @{person.pets}; do
# bamlArr pets "${person}" ".pets"
# for pet in ${pets[@]}; do
  echo "Pet: $pet"
done

