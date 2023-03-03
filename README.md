# BAML

**Bash + YAML for a better shell**

Powered by yq

## Basic Example
```
curl https://raw.githubusercontent.com/.../install.sh | bash
baml << EOF

person="
name: Jane Austen
age: 23
pets:
- name: Rover
- name: Goldie
"

echo %person.name

for pet in @person.pets; do
  echo %{ pet.name | upcase }
done

EOF
```

## How it Works
BAML transpiles your BAML script into a bash script, which can run anywhere (Bash 4.3 and up).

BAML relies on `yq` being installed. The installer will add it if it's not available.


-------

# OLD STUFF

-------

## Examples
Hello world:
```bash
baml -c << EOF
echo "Hello world!"
EOF
# Hello world!
```

Further examples will omit the `baml -c <<< EOF`

YAML file as input:
```bash
cat << EOF >> person.yaml
name: Jane
age: 23
pets:
- name: rover
  age: 10
- name: goldie
  age: 1
EOF

load person.yaml       # Puts this file as the input to all yq commands
echo "Hello %(.name)!" # Anything in %() is a yq command
echo "You have %(.pets | length) pets"
```

load from cURL:
```bash
curl https://api.github.com/ | load
echo %(.current_user_url)
```

loops:
```bash
load person.yaml
echo "Hello %(.name)!"
for pet in %(.pets[]); do
  echo "  and hello to your pet %(.pet.name) too!"
  if [[ %(.pet.age) -lt 2 ]]; then
    echo "  (who is pretty young!)"
  fi
done
for pet in %(.pets[] | select(.age < 2)); do
  echo "%(.pet.name) is only %(.pet.age) years old!"
done
```

math:
```bash
load person.yaml
minutesPerYear=$(( 365 * 24 * 60 )) # Roughly!
ageInMinutes=$(( %(.age) * minutesPerYear ))
```

structured variables:
```bash
jack=%{
name: Jack
age: 24
}
jill=%{
name: Jill
age: 25
}
people=%{
- %(jack)
- %(jill)
}
for person in %(.people[]); do
  echo "hello %(.person.name)!"
done
```
