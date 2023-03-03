package run

import (
	"os"
	"os/exec"
	"fmt"
	"errors"
)

func runBash(script string, scope Scope) (string, error) {
	argstr := []string{"-c", script}
	cmd := exec.Command("/bin/bash", argstr...)
	cmd.Env = os.Environ()
	for key, val := range scope {
		str, err := scopeTypeToString(val)
		if err != nil {
			return errors.New("Couldn't convert " + key + " to an env variable for bash")
		}
		cmd.Env = append(cmd.Env, key + "=" + str)
	}
	out, err := cmd.Output()
	if err != nil {
		return err
	}
	fmt.Println(string(out))
	return out, nil
}

