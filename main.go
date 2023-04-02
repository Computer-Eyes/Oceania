package main

import (
	"context"
	"fmt"
	"os"

	"github.com/docker/docker/api/types"
	"github.com/docker/docker/client"
)

func main() {
	// Create a new docker client
	cli, err := client.NewClientWithOpts(client.FromEnv)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error al crear el cliente de Docker: %v\n", err)
		os.Exit(1)
	}

	// Get all the currently running containers
	containers, err := cli.ContainerList(context.Background(), types.ContainerListOptions{})
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error al obtener la lista de contenedores: %v\n", err)
		os.Exit(1)
	}

	for _, container := range containers {
		state := "⬤"
		if container.State == "running" {
			state = "\033[32m⬤\033[0m" // Green if it's running
		} else if container.State == "exited" {
			state = "\033[31m⬤\033[0m" // Red if it's not running
		} else {
			state = "\033[33m⬤\033[0m"
		}

		fmt.Printf("%s %s\n", container.ID[:12], state)
	}
}
