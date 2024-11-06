package main

import (
	"fmt"
	"github.com/auperman-lab/soLab/lab5/task1"
	"io"
	"log"
	"log/slog"
	"math/rand"
	"os"
	"sync"
	"time"
)

func main() {
	m := task1.NewRWMutex()
	var wg sync.WaitGroup

	file, err := os.OpenFile("/Users/macriidanu/Desktop/soLab/lab5/asd.txt", os.O_RDWR, 0666)
	if err != nil {
		slog.Error("Can't open file ")
		log.Fatal(err)
	}
	defer file.Close()

	readerCount := 5
	writersCount := 2

	for i := 0; i < readerCount; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			ReadFile(file, m)
		}()
	}

	for i := 0; i < writersCount; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			WriteFile(file, m)
		}()
	}

	wg.Wait()

}

func ReadFile(file *os.File, m *task1.RWMutex) {
	m.RLock()
	fmt.Println("reader rLocked mutex")

	if _, err := file.Seek(0, io.SeekStart); err != nil {
		log.Println("Error resetting file pointer:", err)
		panic(err)
	}

	data := make([]byte, 1024)
	if _, err := file.Read(data); err != nil {
		if err.Error() == "EOF" {
		} else {
			log.Println("Error reading file:", err)
			panic(err)
		}
	}
	fmt.Println(string(data))
	fmt.Println("reader rUnlocked mutex")

	m.RUnlock()

	time.Sleep(time.Second * time.Duration(rand.Intn(3)))
}

func WriteFile(file *os.File, m *task1.RWMutex) {
	m.Lock()
	fmt.Println("writer locked mutex")
	data := []byte(":^)")
	_, err := file.Write(data)
	if err != nil {
		if err.Error() == "EOF" {
		} else {
			log.Println("Error writing file:", err)
			panic(err)
		}
	}
	fmt.Println("writer unlocked mutex")
	m.Unlock()

	time.Sleep(time.Second * time.Duration(rand.Intn(3)))

}
