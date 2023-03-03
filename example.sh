#! /bin/bash
script="eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaAoKZnVuY3Rpb24gYmFtbCgpIHsKICBlY2hvICJcJHsxfSIgfCB5cSBldmFsICJcJHsyfSIgLQp9CgpmdW5jdGlvbiBiYW1sQXJyKCkgewogIGxvY2FsIC1uIHJlc3VsdD1cJDEKICByZXN1bHQ9XCQoYmFtbCAiXCR7Mn0iICJcJHszfVtdIikKfQpFT0YKKSA7IGNhdCAkQkFNTF9GSUxFOyB9IFwKICB8IGdyZXAgLXYgIiNub19iYW1sIiBcCiAgfCBzZWQgLWUgJ3MvJXtccypcKFtbOmFsbnVtOl1dXCtcKVwoLipcKVxzKn0vJChiYW1sICIke1wxfSIgJyInXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVwoLipcKVxzKn1cKC4qXCkkLyQoYmFtbEFyciBfdG1wICIke1wyfSIgJyInXDMnIicpXG5cMSR7X3RtcFtAXX1cNC9nJyBcCiAgfCAvYmluL2Jhc2gK"
echo "${script}" | base64 -d | BAML_FILE=$0 /bin/bash #no_baml
exit 0 #no_baml

person="
name: Jane Austen
age: 23
pets:
- Rover
- Goldie
"

echo -e "${person}"

echo %{person.name}

echo %{person.pets[0]}

echo %{person.name | upcase}

firstName=%{ person.name | split(" ") | .[0] }

echo "first name: $firstName"

if [[ %{person.age} -gt 23 ]]; then
  echo %{person.name} can drink!
fi
if [[ %{person.pets[0]} == "Rover" ]]; then
  echo "it's rover!"
fi

if [[ %{person.pets | length} -gt 1 ]]; then
  echo "more than one pet!"
fi

for pet in @{person.pets}; do
  echo "Pet: $pet"
done

