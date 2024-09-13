package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, Go!")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Listening on port 9090...")
    err := http.ListenAndServe(":9090", nil)
    if err != nil {
        fmt.Println("Error starting server:", err)
    }
}