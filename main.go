package main

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/mattn/go-sqlite3"
)

func main() {
	db, dbOpenErr := sql.Open("sqlite3", "./aircraft.db")
	if dbOpenErr != nil {
		log.Fatalln("[ERROR] Could not open database due to: ", dbOpenErr)
	}

	defer db.Close()
	getAircraft := "select \"N-NUMBER\" from mappings where trim(\"MODE S CODE HEX\") = $1"
	tx, err := db.Begin()
	if err != nil {
		log.Fatalln("[ERROR] Could begin DB connection: ", err)
	}

	log.Print("[INFO] Starting Server")
	r := gin.Default()
	r.GET("/icaoTranslate", func(c *gin.Context) {
		icao := c.Query("icao")
		if icao == "" {
			c.JSON(http.StatusForbidden, gin.H{
				"status": "ICAO not provided",
				"got":    icao,
			})
			return
		}

		stmt, err := tx.Prepare(getAircraft)
		if err != nil {
			log.Fatalln("[ERROR] Could prepare statement: ", err)
		}
		defer stmt.Close()

		result, err := stmt.Query(icao)
		if err != nil {
			log.Fatalln("[ERROR] could not get result: ", err)
		}
		var tailNumber string
		for result.Next() {
			err = result.Scan(&tailNumber)
		}
		c.JSON(http.StatusOK, gin.H{
			"prefix": "N",
			"number": tailNumber,
		})
	})
	r.Run()
}
