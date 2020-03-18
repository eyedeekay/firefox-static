package main

import (
	"crypto/tls"
	"log"
	"net/http"

	"github.com/eyedeekay/firefox-static/sammy"
    "github.com/eyedeekay/sam3/i2pkeys"
)

func main() {
	fs := http.FileServer(http.Dir("./"))
	http.Handle("/", fs)

	cfg := &tls.Config{
		MinVersion:               tls.VersionTLS12,
		CurvePreferences:         []tls.CurveID{tls.CurveP521, tls.CurveP384, tls.CurveP256},
		PreferServerCipherSuites: true,
		CipherSuites: []uint16{
			tls.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
			tls.TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,
			tls.TLS_RSA_WITH_AES_256_GCM_SHA384,
			tls.TLS_RSA_WITH_AES_256_CBC_SHA,
		},
	}
	srv := &http.Server{
		Addr:         ":443",
		Handler:      fs,
		TLSConfig:    cfg,
		TLSNextProto: make(map[string]func(*http.Server, *tls.Conn, http.Handler), 0),
	}

	i2plistener, err := sammy.Sammy()
	if err != nil {
		log.Fatal(err)
	}else{
        log.Println(i2plistener.Addr().(i2pkeys.I2PAddr).Base32())
    }
	log.Fatal(srv.ServeTLS(i2plistener, "../tls.crt", "../tls.key"))
}
