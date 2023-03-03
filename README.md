# BAML

**Bash + YAML for a better shell**, powered by [yq](https://github.com/mikefarah/yq/)

BAML lets you write native `bash` scripts with a bunch of extra features provided by `yq`:
* native YAML/JSON support
* structured variables (maps and arrays)
* neater for loops
* string utilities
* ...and a bunch more

## Installation
While BAML depends on `yq` being installed in your environment, it requires
no additional installation--just put a one line command at the top of
your script:
```bash
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaApmdW5jdGlvbiBiYW1sKCkgewogIGVjaG8gIlwkezF9IiB8IHlxIGUgIlwkezJ9IiAtCn0KZnVuY3Rpb24gYmFtbEFycigpIHsKICBsb2NhbCAtbiByZXN1bHQ9XCQxCiAgcmVzdWx0PSgpCiAgaXRlbXM9XCQoZWNobyAiXCR7Mn0iIHwgeXEgZSAtbz1qIC1JPTAgIlwkezN9W10iIC0pCiAgd2hpbGUgSUZTPSByZWFkIC1yIGl0ZW07IGRvCiAgICByZXN1bHQrPSgiXCQoZWNobyAiXCR7aXRlbX0iIHwgeXEgZSAtcCBqc29uIC1vIHlhbWwgJy4nIC0pIikKICBkb25lIDw8PCAiXCRpdGVtcyIKfQpFT0YKKSA7IGNhdCAkQkFNTF9GSUxFOyB9IFwKICB8IGdyZXAgLXYgIiNub19iYW1sIiBcCiAgfCBzZWQgLWUgJ3MvJXtccypcKFtbOmFsbnVtOl1dXCtcKVwoXC5bXn1dKlwpXHMqfS8kKGJhbWwgIiR7XDF9IiAnIidcMiciJykvZycgXAogIHwgc2VkIC1lICdzLyV7XHMqXChbWzphbG51bTpdXVwrXClcKFtefV0qXClccyp9LyQoYmFtbCAiJHtcMX0iICciJy4gXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVwoXC5bXn1dKlwpXHMqfVwoLipcKSQvYmFtbEFyciBfdG1wICIke1wyfSIgJyInXDMnIidcblwxIiR7X3RtcFtAXX0iXDQvZycgXAogIHwgc2VkIC1lICdzL15cKC4qXClAe1xzKlwoW1s6YWxudW06XV1cK1wpXHMqXChbXn1dKlwpXHMqfVwoLipcKSQvYmFtbEFyciBfdG1wICIke1wyfSIgJyInLlwzJyInXG5cMSIke190bXBbQF19Ilw0L2cnCg==" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash -s $@ ; exit $? #no_baml
```

## Basic Example
```bash
#! /bin/bash
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaApmdW5jdGlvbiBiYW1sKCkgewogIGVjaG8gIlwkezF9IiB8IHlxIGUgIlwkezJ9IiAtCn0KZnVuY3Rpb24gYmFtbEFycigpIHsKICBsb2NhbCAtbiByZXN1bHQ9XCQxCiAgcmVzdWx0PSgpCiAgaXRlbXM9XCQoZWNobyAiXCR7Mn0iIHwgeXEgZSAtbz1qIC1JPTAgIlwkezN9W10iIC0pCiAgd2hpbGUgSUZTPSByZWFkIC1yIGl0ZW07IGRvCiAgICByZXN1bHQrPSgiXCQoZWNobyAiXCR7aXRlbX0iIHwgeXEgZSAtcCBqc29uIC1vIHlhbWwgJy4nIC0pIikKICBkb25lIDw8PCAiXCRpdGVtcyIKfQpFT0YKKSA7IGNhdCAkQkFNTF9GSUxFOyB9IFwKICB8IGdyZXAgLXYgIiNub19iYW1sIiBcCiAgfCBzZWQgLWUgJ3MvJXtccypcKFtbOmFsbnVtOl1dXCtcKVwoXC5bXn1dKlwpXHMqfS8kKGJhbWwgIiR7XDF9IiAnIidcMiciJykvZycgXAogIHwgc2VkIC1lICdzLyV7XHMqXChbWzphbG51bTpdXVwrXClcKFtefV0qXClccyp9LyQoYmFtbCAiJHtcMX0iICciJy4gXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVwoXC5bXn1dKlwpXHMqfVwoLipcKSQvYmFtbEFyciBfdG1wICIke1wyfSIgJyInXDMnIidcblwxIiR7X3RtcFtAXX0iXDQvZycgXAogIHwgc2VkIC1lICdzL15cKC4qXClAe1xzKlwoW1s6YWxudW06XV1cK1wpXHMqXChbXn1dKlwpXHMqfVwoLipcKSQvYmFtbEFyciBfdG1wICIke1wyfSIgJyInLlwzJyInXG5cMSIke190bXBbQF19Ilw0L2cnCg==" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash -s $@ ; exit $? #no_baml

person="
name: Jane Austen
age: 23
pets:
- name: Rover
- name: Goldie
"

# Easily access deeply nested fields
echo %{person.name} is %{person.age} years old
echo %{person.pets[0]}

# Pretty for loops
for pet in @{person.pets}; do
  echo "Pet: %{pet.name}"
done

# Load JSON/YAML from an API
repositories=$(curl -s "https://api.github.com/orgs/fairwindsops/repos")
for repo in @{repositories}; do
  echo %{repo.full_name} has %{repo.stargazers_count} stargazers
done

# String manipulation is easy with yq
echo %{person.name | upcase}
firstName=%{ person.name | split(" ") | .[0] }
echo "first name: %{firstName}"

# Everything works nicely with if statements
if [[ %{person.age} -gt 21 ]]; then
  echo %{person.name} can drink!
fi
if [[ %{person.pets[0].name} == "Rover" ]]; then
  echo "it's rover!"
fi

# You can read arguments and environment variables like normal
echo "You ran this script with argument $1"
echo "Your timezone is $TZ"

# You can also muck with arguments/env in the same way
echo "Your city is %{ TZ | split("/") | .[1] | sub("_", " ") }"

if [[ %{person.pets | length} -gt 1 ]]; then
  echo "more than one pet!"
  # Exit codes work as expected
  exit 1
fi
```

## How it Works
BAML transpiles your BAML script into a bash script, which can run anywhere (Bash 4.3 and up).

BAML relies on `yq` being installed. The installer will add it if it's not available.


