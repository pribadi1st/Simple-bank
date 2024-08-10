package db

import (
	"context"
	"log"
	"os"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"
)

var queries *Queries
var testDB *pgxpool.Pool

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:test@localhost:5432/simple_bank?sslmode=disable"
)

func TestMain(m *testing.M) {
	var err error
	// testDB, err = pgxpool.Connect(context.Background(), dbSource)
	config, err := pgxpool.ParseConfig(dbSource)
	if err != nil {
		log.Fatal("cannot parse config:", err)
	}

	testDB, err = pgxpool.NewWithConfig(context.Background(), config)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	queries = New(testDB)
	code := m.Run()
	testDB.Close()
	os.Exit(code)
}
