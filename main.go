package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, Go 副本信息!")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Listening on port 9091...")
    err := http.ListenAndServe(":9091", nil)
    if err != nil {
        fmt.Println("Error starting server:", err)
    }
}