package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Hello, Go!")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Listening on :9090")
    err := http.ListenAndServe(":9090", nil)
    if err != nil {
        fmt.Println("Error starting server:", err)
    }
}