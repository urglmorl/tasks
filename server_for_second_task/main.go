package main

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"math/rand"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"time"
)

const Port string = ":8080"

type City struct {
	Id       int    `json:"id"`
	Name     string `json:"name"`
	Postcode string `json:"postcode"`
	Emblem   string `json:"emblem"`
}

type User struct {
	Id       int    `json:"id"`
	Login    string `json:"login"`
	Password string `json:"password"`
	Token    string `json:"token"`
}

var Cities = [...]City{
	{
		Id:       1,
		Name:     "Абакан",
		Postcode: "000001",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       2,
		Name:     "Абинск",
		Postcode: "000002",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       3,
		Name:     "Агата",
		Postcode: "000003",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       4,
		Name:     "Агинское",
		Postcode: "000004",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       5,
		Name:     "Адлер",
		Postcode: "000005",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       6,
		Name:     "Адыгейск",
		Postcode: "000006",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       7,
		Name:     "Азов",
		Postcode: "000007",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       8,
		Name:     "Алагир",
		Postcode: "000008",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       9,
		Name:     "Алапаевск",
		Postcode: "000009",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       10,
		Name:     "Алдан",
		Postcode: "000010",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       11,
		Name:     "Александров",
		Postcode: "000011",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       12,
		Name:     "Александровск",
		Postcode: "000012",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       13,
		Name:     "Алексин",
		Postcode: "000013",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       14,
		Name:     "Алушта",
		Postcode: "000014",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       15,
		Name:     "Алупка",
		Postcode: "000015",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       16,
		Name:     "Амдерма",
		Postcode: "000016",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       17,
		Name:     "Амурск",
		Postcode: "000017",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       18,
		Name:     "Анадырь",
		Postcode: "000018",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       19,
		Name:     "Анапа",
		Postcode: "000019",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
	{
		Id:       20,
		Name:     "Ангарск",
		Postcode: "000020",
		Emblem:   "localhost:8080/assets/emblem.png",
	},
}

var Users = [...]User{
	{
		Id:       1,
		Login:    "admin",
		Password: "admin",
		Token:    "",
	},
}

func main() {
	stopChan := make(chan os.Signal)
	signal.Notify(stopChan, os.Interrupt)

	api := mux.NewRouter()

	api.HandleFunc("/auth", AuthHandler).Methods("POST")
	api.HandleFunc("/cities", CitiesHandler).Methods("GET")
	api.HandleFunc("/cities/{id:[0-9]+}", CityHandler).Methods("GET")
	api.PathPrefix("/assets/").Handler(http.StripPrefix("/assets/", http.FileServer(http.Dir("assets/"))))

	server := &http.Server{
		Addr:         Port,
		ReadTimeout:  60 * time.Second,
		WriteTimeout: 60 * time.Second,
		IdleTimeout:  60 * time.Second,
		Handler:      api,
	}

	go func() {
		log.Println("Api listening on port ", Port)
		if err := server.ListenAndServe(); err != nil {
			log.Printf("listen: %s\n", err)
		}
	}()

	<-stopChan

	log.Println("Shutting down server...")
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	err := server.Shutdown(ctx)
	if err != nil {
		fmt.Println(err.Error())
	}
	defer cancel()
	log.Println("Server gracefully stopped!")
}

func CitiesHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Cities passed")
	w.Header().Set("Content-Type", "application/json")
	err := json.NewEncoder(w).Encode(Cities)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
	}
}

func CityHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Cities passed")
	w.Header().Set("Content-Type", "application/json")
	vars := mux.Vars(r)
	id, _ := strconv.Atoi(vars["id"])
	var city City
	for _, item := range Cities {
		if item.Id == id {
			city = item
		}
	}
	err := json.NewEncoder(w).Encode(city)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
	}
}

func AuthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	fmt.Println("Auth passed")
	var usr User

	err := json.NewDecoder(r.Body).Decode(&usr)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	fmt.Println(usr)
	for _, user := range Users {
		if user.Login == usr.Login && user.Password == usr.Password {
			user.Token = GenerateToken()
			err = json.NewEncoder(w).Encode(usr.Token)
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				return
			}
		}
	}
	w.WriteHeader(http.StatusNotFound)
}

func GenerateToken() string {
	const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	var seededRand = rand.New(rand.NewSource(time.Now().UnixNano()))
	b := make([]byte, 32)
	for i := range b {
		b[i] = alphabet[seededRand.Intn(len(alphabet))]
	}
	return string(b)
}
