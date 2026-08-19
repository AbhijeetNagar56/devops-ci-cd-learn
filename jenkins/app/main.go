package main

import (
	"fmt"
	"log"
	"net/http"
)

func defaultHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Go Backend: you are at endpoint: %s\n", r.URL.Path)
}

func statusHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Status: online")
}

func greetHandler(res http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(res, "hello World")
}

func main() {
	http.HandleFunc("/", defaultHandler)
	http.HandleFunc("/api/status", statusHandler)
	http.HandleFunc("/api/greet", greetHandler)

	log.Println("Server starting on http://localhost:3000")
	if err := http.ListenAndServe(":3000", nil); err != nil {
		log.Fatal("Server failed to start:", err)
	}
}
