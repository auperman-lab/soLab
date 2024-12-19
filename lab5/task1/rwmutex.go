package task1

import "sync"

type RWMutex struct {
	mu          sync.Mutex
	readerCount uint32
	writerCount uint32
	writing     bool
	rCond       *sync.Cond
	wCond       *sync.Cond
}

func NewRWMutex() *RWMutex {
	rw := &RWMutex{}
	rw.rCond = sync.NewCond(&rw.mu)
	rw.wCond = sync.NewCond(&rw.mu)
	rw.readerCount = 0
	rw.writerCount = 0
	return rw
}

func (m *RWMutex) RLock() {
	m.mu.Lock()
	defer m.mu.Unlock()
	for m.writing || m.writerCount > 0 {
		m.rCond.Wait()
	}
	m.readerCount++

}

func (m *RWMutex) RUnlock() {
	m.mu.Lock()
	defer m.mu.Unlock()

	m.readerCount--
	if m.readerCount == 0 {
		m.wCond.Signal()
	}

}

func (m *RWMutex) Lock() {
	m.mu.Lock()
	defer m.mu.Unlock()
	m.writerCount++
	for m.writing || m.readerCount > 0 {
		m.wCond.Wait()
	}
	m.writerCount--

}

func (m *RWMutex) Unlock() {
	m.mu.Lock()
	defer m.mu.Unlock()

	m.writerCount--
	m.writing = false
	if m.writerCount == 0 {
		m.rCond.Broadcast()
	} else {
		m.wCond.Signal()
	}
}
