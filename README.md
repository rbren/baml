# BAML

**Bash + YAML for a better shell**, powered by the magical [yq](https://github.com/mikefarah/yq/)

BAML lets you write native `bash` scripts with a bunch of extra features powered by `yq`:
* native YAML/JSON support
* structured, nested variables (maps and arrays)
* neater `for` loops and `if` statements
* string utilities
* math
* ...and a bunch more

## Installation
Be sure to have [yq](https://github.com/mikefarah/yq/) 4.x installed. 4.31.x is required for the
example below.

While BAML depends on `yq` being installed in your environment, it requires
no additional installation--just put a one line command at the top of
your script:
```bash
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaApmdW5jdGlvbiBiYW1sKCkgewogIGVjaG8gIlwkezF9IiB8IHlxIGUgIlwkezJ9IiAtCn0KZnVuY3Rpb24gYmFtbEFycigpIHsKICBsb2NhbCAtbiByZXN1bHQ9XCQxCiAgcmVzdWx0PSgpCiAgaXRlbXM9XCQoZWNobyAiXCR7Mn0iIHwgeXEgZSAtbz1qIC1JPTAgIlwkezN9IHwgLltdIiAtKQogIHdoaWxlIElGUz0gcmVhZCAtciBpdGVtOyBkbwogICAgaWYgW1sgXCR7I2l0ZW19IC1lcSAwIF1dOyB0aGVuCiAgICAgIGNvbnRpbnVlCiAgICBmaQogICAgcmVzdWx0Kz0oIlwkKGVjaG8gIlwke2l0ZW19IiB8IHlxIGUgLXAganNvbiAtbyB5YW1sICcuJyAtKSIpCiAgZG9uZSA8PDwgIlwkaXRlbXMiCn0KRU9GCikgOyBjYXQgJEJBTUxfRklMRTsgfSBcCiAgfCBncmVwIC12ICIjbm9fYmFtbCIgXAogIHwgc2VkIC1lICdzLyV7XHMqXChbWzphbG51bTpdXVwrXClcKFwuW159XSpcKVxzKn0vJChiYW1sICIke1wxfSIgJyInXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy8le1xzKlwoW1s6YWxudW06XV1cK1wpXChbXn1dKlwpXHMqfS8kKGJhbWwgIiR7XDF9IiAnIicuIFwyJyInKS9nJyBcCiAgfCBzZWQgLWUgJ3MvXlwoLipcKUB7XHMqXChbWzphbG51bTpdXVwrXClcKFwuW159XSpcKVxzKn1cKC4qXCkkL2JhbWxBcnIgX3RtcCAiJHtcMn0iICciJ1wzJyInXG5cMSIke190bXBbQF19Ilw0L2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVxzKlwoW159XSpcKVxzKn1cKC4qXCkkL2JhbWxBcnIgX3RtcCAiJHtcMn0iICciJy5cMyciJ1xuXDEiJHtfdG1wW0BdfSJcNC9nJwo=" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash -s $@ ; exit $? #no_baml
```
See below for details on how this works.

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

## Advanced Usage
See the list of [yq operators](https://mikefarah.gitbook.io/yq/operators) for more possibilities.
Not everything has been tested (see `./test` to check out what's covered so far).

## How it Works
BAML transpiles your BAML script into a bash script, which can run anywhere (Bash 4.3 and up).

The transpiler code is contained in `./transpile.sh`. The one-line install command encodes this file in base64.

The install command works in three steps:
* It decodes the transpiler
* It runs the transpiler by sending it to `/bin/bash`. It passes in the current file as an environment variable, `BAML_FILE`, which it reads from `$0`.
* The output of the transpiler is a normal bash script--the transpiled version of your script. This gets passed to `/bin/bash`, along with any other arguments.

## TODO
* Support literals, like `%{"hello" | upcase}` or `%{22 * 2 + 1}`
* Nested interpolation, like `%{person[%{key}]}`
* GitHub action to run tests
* Any potential performance gains (it can be a little slow)
