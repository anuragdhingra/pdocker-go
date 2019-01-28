package main

import (
	"context"
	"fmt"
	_ "github.com/anuragdhingra/elasticsearch-go/data"
	"github.com/olivere/elastic"
	"log"
	"net/http"
)
func main() {

	http.HandleFunc("/", Hello)

	fmt.Println("Listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))

	client, err := elastic.NewClient(
		elastic.SetURL("http://localhost:9200"),
		elastic.SetSniff(false),
	)
	if err != nil {
		panic(err)
	}
	defer client.Stop()

	_, err = client.Get().
		Index("index").
		Type("Type").
		Id("Id").
		Do(context.Background())
	if err != nil {
		panic(err)
	}
}

func Hello (w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from golang")
}