package main

import (
	"github.com/auperman-lab/soLab/lab4/task2"
	"sync"
)

func main() {
	wg := sync.WaitGroup{}

	prod1 := task2.NewProducer(1, 5, 3)
	prod2 := task2.NewProducer(2, 5, 3)
	prod3 := task2.NewProducer(3, 10, 3)

	consumer := task2.NewConsumer(0, 5)

	wg.Add(3)
	go prod1.Produce(&wg)
	go prod2.Produce(&wg)
	go prod3.Produce(&wg)

	wg.Add(3)
	go consumer.Consume(prod1, &wg)
	go consumer.Consume(prod2, &wg)
	go consumer.Consume(prod3, &wg)

	wg.Wait()

}
