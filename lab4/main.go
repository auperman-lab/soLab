package main

import (
	"github.com/auperman-lab/soLab/lab4/task2"
	"sync"
)

func main() {
	wg := sync.WaitGroup{}

	numProducers := 3
	maxItemsProduced := 5
	maxItemsBuffer := 3

	producers := make([]*task2.Producer, numProducers)
	for i := 0; i < numProducers; i++ {
		producers[i] = task2.NewProducer(int8(i+1), maxItemsProduced, maxItemsBuffer)
	}

	consumer := task2.NewConsumer(0, 5)

	for _, producer := range producers {
		wg.Add(1)
		go producer.Produce(&wg)
	}

	for _, producer := range producers {
		wg.Add(1)
		go consumer.Consume(producer, &wg)

	}

	wg.Wait()

}
