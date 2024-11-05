package task2

import (
	"fmt"
	"sync"
	"time"
)

type Consumer struct {
	id        int8
	semaphore chan bool
}

func NewConsumer(id int8, maxItemConsumed int) *Consumer {
	return &Consumer{
		id:        id,
		semaphore: make(chan bool, maxItemConsumed),
	}
}

func (c *Consumer) Consume(prod *Producer, wg *sync.WaitGroup) {
	defer wg.Done()
	for item := range prod.products {
		c.semaphore <- true
		fmt.Printf("Consumer %d consumed item: %c from producer %d\n", c.id, item, prod.id)
		time.Sleep(time.Second * 3)
		<-prod.semaphore
		<-c.semaphore
	}
	fmt.Printf("Consumer %d finished consuming.\n", c.id)
}
