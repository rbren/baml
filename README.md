# BAML

**Bash + YAML for a better shell**, powered by [yq](https://github.com/mikefarah/yq/)

BAML lets you write native `bash` scripts with a bunch of extra features provided by `yq`:
* native YAML/JSON support
* structured variables (maps and arrays)
* neater for loops
* string utilities
* ...and a bunch more

## Installation
Be sure to have [yq](https://github.com/mikefarah/yq/) 4.x installed. 4.31.x is required for the
example below.

While BAML depends on `yq` being installed in your environment, it requires
no additional installation--just put a one line command at the top of
your script:
```bash
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaApmdW5jdGlvbiBiYW1sKCkgewogIGVjaG8gIlwkezF9IiB8IHlxIGUgIlwkezJ9IiAtCn0KZnVuY3Rpb24gYmFtbEFycigpIHsKICBsb2NhbCAtbiByZXN1bHQ9XCQxCiAgcmVzdWx0PSgpCiAgaXRlbXM9XCQoZWNobyAiXCR7Mn0iIHwgeXEgZSAtbz1qIC1JPTAgIlwkezN9W10iIC0pCiAgd2hpbGUgSUZTPSByZWFkIC1yIGl0ZW07IGRvCiAgICBpZiBbWyBcJHsjaXRlbX0gLWVxIDAgXV07IHRoZW4KICAgICAgY29udGludWUKICAgIGZpCiAgICByZXN1bHQrPSgiXCQoZWNobyAiXCR7aXRlbX0iIHwgeXEgZSAtcCBqc29uIC1vIHlhbWwgJy4nIC0pIikKICBkb25lIDw8PCAiXCRpdGVtcyIKfQpFT0YKKSA7IGNhdCAkQkFNTF9GSUxFOyB9IFwKICB8IGdyZXAgLXYgIiNub19iYW1sIiBcCiAgfCBzZWQgLWUgJ3MvJXtccypcKFtbOmFsbnVtOl1dXCtcKVwoXC5bXn1dKlwpXHMqfS8kKGJhbWwgIiR7XDF9IiAnIidcMiciJykvZycgXAogIHwgc2VkIC1lICdzLyV7XHMqXChbWzphbG51bTpdXVwrXClcKFtefV0qXClccyp9LyQoYmFtbCAiJHtcMX0iICciJy4gXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVwoXC5bXn1dKlwpXHMqfVwoLipcKSQvYmFtbEFyciBfdG1wICIke1wyfSIgJyInXDMnIidcblwxIiR7X3RtcFtAXX0iXDQvZycgXAogIHwgc2VkIC1lICdzL15cKC4qXClAe1xzKlwoW1s6YWxudW06XV1cK1wpXHMqXChbXn1dKlwpXHMqfVwoLipcKSQvYmFtbEFyciBfdG1wICIke1wyfSIgJyInLlwzJyInXG5cMSIke190bXBbQF19Ilw0L2cnCg==" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash -s $@ ; exit $? #no_baml
```

## Basic Example
Run `./example.sh` to try this example.

```bash
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
```

## How it Works
BAML transpiles your BAML script into a bash script, which can run anywhere (Bash 4.3 and up).

The one-liner has the transpiler (from `./transpile.sh`) encoded as base64. It:
* decodes the transpiler
* pipes the transpiler code to `/bin/bash`, passing in the current file as an env var `BAML_FILE`
* takes the transpiler stdout (which is now bash) and pipes that to `/bin/bash`, along with script arguments

BAML relies on `yq` being installed, and uses it under the hood.

## TODO
* Support literals, like `%{"hello" | upcase}` or `%{22 * 2 + 1}`
* Nested interpolation, like `%{person[%{key}]}`
* GitHub action to run tests
* Any potential performance gains (it can be a little slow)
