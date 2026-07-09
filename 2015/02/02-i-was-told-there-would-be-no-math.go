package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	fh, err := os.Open("./input.txt")
	if err != nil {
		panic(err)
	}
	defer fh.Close()

	wrappingPaperTotal, ribbonTotal := 0, 0

	lineScanner := bufio.NewScanner(fh)
	for lineScanner.Scan() {
		line := lineScanner.Text()
		re := regexp.MustCompile(`^(\d+)x(\d+)x(\d+)$`)
		m := re.FindStringSubmatch(line)
		a, _ := strconv.Atoi(m[1])
		b, _ := strconv.Atoi(m[2])
		c, _ := strconv.Atoi(m[3])
		wrappingPaperTotal += wrappingPaperRequired(a, b, c)
		ribbonTotal += ribbonRequired(a, b, c)
	}

	if err := lineScanner.Err(); err != nil {
		panic(err)
	}

	fmt.Printf("Wrapping paper required %d\n", wrappingPaperTotal)
	fmt.Printf("Ribbon required %d\n", ribbonTotal)
}

func wrappingPaperRequired(a, b, c int) int {
	sides := [3]int{a * b, b * c, c * a}
	minSide := -1
	for _, s := range sides {
		if minSide == -1 || s < minSide {
			minSide = s
		}
	}
	return 2*(a*b+b*c+c*a) + minSide
}

func ribbonRequired(a, b, c int) int {
	perimeters := [3]int{2 * (a + b), 2 * (a + c), 2 * (b + c)}
	minPerimeter := -1
	for _, p := range perimeters {
		if minPerimeter == -1 || p < minPerimeter {
			minPerimeter = p
		}
	}
	return minPerimeter + a*b*c
}
