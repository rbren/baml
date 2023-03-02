package main

import (
	"fmt"
	"github.com/alecthomas/kong"
)

type Context struct {
	Debug bool
}

type RunCmd struct {
	Path string `arg:"" name:"path" help:"YAML file to run." type:"path"`
}

func (run *RunCmd) Run(ctx *Context) error {
	fmt.Println("run!")
	return nil
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
