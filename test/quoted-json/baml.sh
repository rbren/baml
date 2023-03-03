repositories='[{
  "full_name": "stackstorm",
  "stargazers_count": 3,
  "description": "StackStorm (aka \"IFTTT for Ops\") is event-driven automation"
}]'

for repo in @{repositories}; do
  echo %{repo.full_name} has %{repo.stargazers_count} stargazers
done

