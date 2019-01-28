package data

import (
	"database/sql"
	"log"
	"time"
)
import _ "github.com/go-sql-driver/mysql"

var Db *sql.DB

func init() {
	Db, err := sql.Open("mysql", "monstar-lab:password@tcp(localhost:3306)/todo?parseTime=true")
	// To avoid client-side timeout
	Db.SetConnMaxLifetime(time.Second)
	if err != nil {
		log.Println("Problem connecting to DB", err)
		return
	} else {
		log.Println("Successfully connected to DB")
	}
	return
}

