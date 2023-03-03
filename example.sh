#! /bin/bash
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaAoKZnVuY3Rpb24gYmFtbCgpIHsKICBlY2hvICJcJHsxfSIgfCB5cSBldmFsICJcJHsyfSIgLQp9CgpmdW5jdGlvbiBiYW1sQXJyKCkgewogIGxvY2FsIC1uIHJlc3VsdD1cJDEKICByZXN1bHQ9XCQoYmFtbCAiXCR7Mn0iICJcJHszfVtdIikKfQpFT0YKKSA7IGNhdCAkQkFNTF9GSUxFOyB9IFwKICB8IGdyZXAgLXYgIiNub19iYW1sIiBcCiAgfCBzZWQgLWUgJ3MvJXtccypcKFtbOmFsbnVtOl1dXCtcKVwoW159XSpcKVxzKn0vJChiYW1sICIke1wxfSIgJyInXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVwoW159XSpcKVxzKn1cKC4qXCkkLyQoYmFtbEFyciBfdG1wICIke1wyfSIgJyInXDMnIicpXG5cMSR7X3RtcFtAXX1cNC9nJyBcCg==" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash -s $@ ; exit $? #no_baml

person="
name: Jane Austen
age: 23
pets:
- Rover
- Goldie
"

echo "arg $1"
echo -e "${person}"

echo %{person.name} is %{person.age} years old

for pet in @{person.pets}; do
  echo "Pet: $pet"
done

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
  exit 1
fi

