package task1

import (
	"fmt"
	"math/rand"
	"os"
	"os/signal"
	"syscall"
)

func generateRandomASCII() string {
	chars := make([]byte, 100)
	for i := range chars {
		chars[i] = byte(rand.Intn(95) + 32)
	}
	return string(chars)
}

func SyscallProblem() {
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGUSR1, syscall.SIGUSR2)

	fmt.Println("Program started. Waiting for SIGUSR1 or SIGUSR2...")

	for {
		sig := <-sigChan
		switch sig {
		case syscall.SIGUSR1:
			fmt.Println("SIGUSR1 received.")

		case syscall.SIGUSR2:
			fmt.Println("SIGUSR2 received. Generating 100 random ASCII characters:")
			fmt.Println(generateRandomASCII())
			fmt.Println("Program will now terminate.")
			//os.Exit(0)
			return
		}
	}
}
