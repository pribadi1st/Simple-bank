package util

import (
	"math/rand"
	"strings"
	"time"
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func init() {
	rand.Seed(time.Now().UnixNano())
}

func RandomInit(min, max int64) int64 {
	return rand.Int63n(max-min+1) + min
}

func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphabet)

	for i := 0; i < n; i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

func RandomOwner() string {
	return RandomString(6)
}

func RandomMoney() int64 {
	return RandomInit(0, 1000)
}

func RandomCurrency() string {
	currencies := []string{"EUR", "USD"}
	n := len(currencies)
	return currencies[rand.Intn(n)]
}
