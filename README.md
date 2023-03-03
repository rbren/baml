# BAML

**Bash + YAML for a better shell**, powered by [yq](https://github.com/mikefarah/yq/)

BAML lets you write bash scripts with a bunch of extra features provided by yq:
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
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaAoKZnVuY3Rpb24gYmFtbCgpIHsKICBlY2hvICJcJHsxfSIgfCB5cSBldmFsICJcJHsyfSIgLQp9CgpmdW5jdGlvbiBiYW1sQXJyKCkgewogIGxvY2FsIC1uIHJlc3VsdD1cJDEKICByZXN1bHQ9XCQoYmFtbCAiXCR7Mn0iICJcJHszfVtdIikKfQpFT0YKKSA7IGNhdCAkQkFNTF9GSUxFOyB9IFwKICB8IGdyZXAgLXYgIiNub19iYW1sIiBcCiAgfCBzZWQgLWUgJ3MvJXtccypcKFtbOmFsbnVtOl1dXCtcKVwoW159XSpcKVxzKn0vJChiYW1sICIke1wxfSIgJyInXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVwoW159XSpcKVxzKn1cKC4qXCkkLyQoYmFtbEFyciBfdG1wICIke1wyfSIgJyInXDMnIicpXG5cMSR7X3RtcFtAXX1cNC9nJyBcCg==" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash ; exit $? #no_baml
```

## Basic Example
```bash
#! /bin/bash
echo "eygKY2F0IDw8RU9GCiMhIC9iaW4vYmFzaAoKZnVuY3Rpb24gYmFtbCgpIHsKICBlY2hvICJcJHsxfSIgfCB5cSBldmFsICJcJHsyfSIgLQp9CgpmdW5jdGlvbiBiYW1sQXJyKCkgewogIGxvY2FsIC1uIHJlc3VsdD1cJDEKICByZXN1bHQ9XCQoYmFtbCAiXCR7Mn0iICJcJHszfVtdIikKfQpFT0YKKSA7IGNhdCAkQkFNTF9GSUxFOyB9IFwKICB8IGdyZXAgLXYgIiNub19iYW1sIiBcCiAgfCBzZWQgLWUgJ3MvJXtccypcKFtbOmFsbnVtOl1dXCtcKVwoW159XSpcKVxzKn0vJChiYW1sICIke1wxfSIgJyInXDInIicpL2cnIFwKICB8IHNlZCAtZSAncy9eXCguKlwpQHtccypcKFtbOmFsbnVtOl1dXCtcKVwoW159XSpcKVxzKn1cKC4qXCkkLyQoYmFtbEFyciBfdG1wICIke1wyfSIgJyInXDMnIicpXG5cMSR7X3RtcFtAXX1cNC9nJyBcCg==" | base64 -d | BAML_FILE=$0 /bin/bash | /bin/bash ; exit $? #no_baml

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
if [[ %{person.pets | length} -gt 1 ]]; then
  echo "more than one pet!"
  exit 1
fi

```

## How it Works
BAML transpiles your BAML script into a bash script, which can run anywhere (Bash 4.3 and up).

BAML relies on `yq` being installed. The installer will add it if it's not available.


