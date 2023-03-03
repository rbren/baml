package run
import (
	"fmt"
	"errors"
	"io/ioutil"
	pathParser "path"
	"path/filepath"

	"github.com/qri-io/jsonschema"
	"gopkg.in/yaml.v3"
)

type YAMLFunc struct {
	Input []jsonschema.Schema
	Run []map[string]map[string]interface{}
	Import map[string]string
	Imported map[string]*YAMLFunc
}

func (f *YAMLFunc) RunFull(scope Scope) (interface{}, error) {
	for _, cmd := range f.Run {
		if len(cmd) != 1 {
			return errors.New("Each item under run should only have one key")
		}
		for key, vars := range cmd {
			if key == "bash" {
				instr, ok := vars["cmd"].(string)
				if !ok {
					return errors.New("bash expects a cmd")
				}
				fmt.Println("run bash", instr)
				output, err = runBash(instr, scope)
				if err != nil {
					return nil, err
				}
			} else if depFunc, ok := f.Imported[key]; ok {
				subScope := scope.Copy()
				for key, val := range vars {
					if key == "$$" {
						continue
					}
					subScope[key] = val
				}
				outputVal, err := depFunc.RunFull(subScope)
				if err != nil {
					return nil, err
				}
				if outputKey, ok := vars["$$"]; ok {
					scope[outputKey] = outputVal
				}
			} else {
				fmt.Println("Unknown function", key)
			}
		}
	}
}

func load(path string, rel string, cache map[string]*YAMLFunc) (*YAMLFunc, error) {
	if cache == nil {
		cache = make(map[string]*YAMLFunc)
	}
	if rel != "" {
		rel = pathParser.Dir(rel)
	}
	fullPath := filepath.Join(rel, path)
	var err error
	fullPath, err = filepath.Abs(fullPath)
	if err != nil {
		return nil, err
	}
	if f, ok := cache[fullPath]; ok {
		return f, nil
	}
	content, err := ioutil.ReadFile(fullPath)
	if err != nil {
		return nil, err
	}
	f := YAMLFunc{
		Imported: make(map[string]*YAMLFunc),
	}
	err = yaml.Unmarshal(content, &f)
	if err != nil {
		return nil, err
	}
	cache[fullPath] = &f
	for key, imp := range f.Import {
		if key == "bash" {
			continue
		}
		impF, err := load(imp, fullPath, cache)
		if err != nil {
			return nil, err
		}
		f.Imported[key] = impF
	}
	return &f, nil
}

func Run(path string) error {
	f, err := load(path, "", nil)
	if err != nil {
		return err
	}
	scope := Scope{}
	f.RunFull(scope)
	return err
}
