package main

import (
	"log"
	"net/http"
)

func main() {
    log.SetFlags(log.LstdFlags | log.Lshortfile)
    
    http.HandleFunc("/", func (writer http.ResponseWriter, req *http.Request) {
           log.Printf("Request from %s", req.RemoteAddr)           
           writer.Write([]byte(req.RemoteAddr))           
    })
    
    listenAddr := "0.0.0.0:8080"
    
    log.Printf("Listening on %s", listenAddr)
    if err := http.ListenAndServe(listenAddr, nil); err != nil {
        log.Fatal(err)
    }
}