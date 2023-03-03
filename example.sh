#! /bin/bash
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaApmdW5jdGlvbiBiYW1sKCkgewogIGVjaG8gIlwkezF9IiB8IHlxIGUgIlwkezJ9IiAtCn0KZnVuY3Rpb24gYmFtbEFycigpIHsKICBsb2NhbCAtbiByZXN1bHQ9XCQxCiAgcmVzdWx0PSgpCiAgaXRlbXM9XCQoZWNobyAiXCR7Mn0iIHwgeXEgZSAtbz1qIC1JPTAgIlwkezN9IHwgLltdIiAtKQogIHdoaWxlIElGUz0gcmVhZCAtciBpdGVtOyBkbwogICAgaWYgW1sgXCR7I2l0ZW19IC1lcSAwIF1dOyB0aGVuCiAgICAgIGNvbnRpbnVlCiAgICBmaQogICAgcmVzdWx0Kz0oIlwkKGVjaG8gIlwke2l0ZW19IiB8IHlxIGUgLXAganNvbiAtbyB5YW1sICcuJyAtKSIpCiAgZG9uZSA8PDwgIlwkaXRlbXMiCn0KRU9GCikgOyBjYXQgJEJBTUxfRklMRTsgfSBcCiAgfCBncmVwIC12ICIjbm9fYmFtbCIgXAogIHwgc2VkIC1lICdzLyV7XHMqXChbWzphbG51bTpdXVwrXClcKFwuW159XSpcKVxzKn0vJChiYW1sICIke1wxfSIgJyInXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy8le1xzKlwoW1s6YWxudW06XV1cK1wpXChbXn1dKlwpXHMqfS8kKGJhbWwgIiR7XDF9IiAnIicuIFwyJyInKS9nJyBcCiAgfCBzZWQgLWUgJ3MvXlwoLipcKUB7XHMqXChbWzphbG51bTpdXVwrXClcKFwuW159XSpcKVxzKn1cKC4qXCkkL2JhbWxBcnIgX3RtcCAiJHtcMn0iICciJ1wzJyInXG5cMSIke190bXBbQF19Ilw0L2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVxzKlwoW159XSpcKVxzKn1cKC4qXCkkL2JhbWxBcnIgX3RtcCAiJHtcMn0iICciJy5cMyciJ1xuXDEiJHtfdG1wW0BdfSJcNC9nJwo=" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash -s $@ ; exit $? #no_baml

# Store JSON or YAML as a bash string
person="
name: Jane Austen
age: 23
pets:
- name: Rover
  age: 12
- name: Goldie
  age: 3
"

# Access deeply nested fields. Anything in %{} is a yq query
echo %{person.name} is %{person.age} years old
echo %{person.pets[0].name}

# Easy for loops using @{} to wrap arrays
for pet in @{person.pets}; do
  echo "Pet: %{pet.name}"
done

# Also array mapping. Feature request for filters: https://github.com/mikefarah/yq/issues/1586
for praise in @{person.pets | map("Good dog, " + .name)}; do
  echo %{praise}
done

# String manipulation is easy with yq
echo %{person.name | upcase}
firstName=%{ person.name | split(" ") | .[0] }
echo "first name: %{firstName}"

# Also math
echo %{person.name} is %{person.age * 365} days old

# Load JSON/YAML from an API
repositories=$(curl -s "https://api.github.com/orgs/fairwindsops/repos")
for repo in @{repositories}; do
  echo %{repo.full_name} has %{repo.stargazers_count} stargazers
done

# Everything works nicely with if statements
if [[ %{person.age} -gt 21 ]]; then
  echo %{person.name} can drink!
fi
if [[ %{person.pets[0].name} == "Rover" ]]; then
  echo "it's Rover!"
fi

# You can read arguments and environment variables like normal
echo "You ran this script with argument $1"
echo "Your timezone is $TZ"

# You can also muck with normal string variables using yq
echo "Your city is %{ TZ | split("/") | .[1] | sub("_", " ") }"

if [[ %{person.pets | length} -gt 1 ]]; then
  echo "more than one pet!"
  # Exit codes work as expected
  exit 1
fi
