package task2

import (
	"fmt"
	"math/rand"
	"sync"
)

type Producer struct {
	id               int8
	maxItemsProduced int
	products         chan byte
	semaphore        chan bool
}

func NewProducer(id int8, maxItemsToBeProduced int, maxItemsDone int) *Producer {
	return &Producer{
		id:               id,
		maxItemsProduced: maxItemsToBeProduced,
		products:         make(chan byte, maxItemsDone),
		semaphore:        make(chan bool, maxItemsDone),
	}

}

func (p *Producer) Produce(wg *sync.WaitGroup) {
	defer wg.Done()
	for i := 0; i < p.maxItemsProduced; i++ {
		p.semaphore <- true
		item := byte(rand.Intn(95) + 32)
		fmt.Printf("Producer %d produced item: %c\n", p.id, item)
		p.products <- item
	}
	close(p.products)
}
