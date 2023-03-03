package run

import (
	"encoding/json"
)

type Scope map[string]interface{}

func scopeTypeToString(i interface{}) (string, error) {
	if s, ok := i.(string); ok {
		return s, nil
	}
	b, err := json.Marshal(i)
	if err != nil {
		return "", err
	}
	return string(b), nil
}


