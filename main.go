package main

import (
	"github.com/alecthomas/kong"

	"rbren.io/yaml-programming/pkg/run"
)

type Context struct {
	Debug bool
}

type RunCmd struct {
	Path string `arg:"" name:"path" help:"YAML file to run." type:"path"`
}

func (r *RunCmd) Run(ctx *Context) error {
	return run.Run(r.Path)
}

type CLI struct {
	Debug bool `help:"Enable debug mode."`
	Run RunCmd `cmd:"run" help:"Run a YAML file."`
}

func main() {
	cli := &CLI{}
	ctx := kong.Parse(cli)
	err := ctx.Run(&Context{Debug: cli.Debug})
	ctx.FatalIfErrorf(err)
}
