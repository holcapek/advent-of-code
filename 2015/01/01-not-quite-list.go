package main

import (
	"fmt"
	"io"
	"os"
)

const (
	bufSize = 2 * 1024
)

func main() {

	fh, err := os.Open("./input.txt")
	if err != nil {
		panic(err)
	}
	defer fh.Close()
	stat, err := fh.Stat()
	if err != nil {
		panic(err)
	}
	fmt.Printf("Opened file of size %d\n", stat.Size())

	buf := make([]byte, bufSize)

	floor := 0 // Santa starts on the ground floor (floor 0)
	position := 1
	firstTimeBasementPosition := 0

	for {
		numBytes, err := fh.Read(buf)
		if numBytes == 0 && err == io.EOF {
			fmt.Println("Reached end of file")
			break
		} else if err != nil {
			panic(err)
		}
		fmt.Printf("Read %d bytes\n", numBytes)

		for i := 0; i < numBytes; i++ {
			switch buf[i] {
			case '(':
				floor++
			case ')':
				floor--
			}
			if floor == -1 && firstTimeBasementPosition == 0 {
				firstTimeBasementPosition = position
			}
			position++
		}
	}

	fmt.Printf("Final floor %d\n", floor)
	fmt.Printf("First time in basement at position %d\n", firstTimeBasementPosition)
}
