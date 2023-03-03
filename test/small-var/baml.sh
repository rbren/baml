name="Jane"
echo "your name is %{name}"
echo "your name in uppercase is %{name | upcase}"

pets="
- Goldie
- Rover
"

for pet in @{pets}; do
  echo $pet
done

