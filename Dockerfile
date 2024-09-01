FROM golang:1.22.2-bookworm

RUN apt-get -y update

RUN apt-get install -y unzip
RUN apt-get install -y build-essential
RUN apt-get install -y unzip
RUN apt-get install -y curl
RUN apt-get install -y sqlite3

WORKDIR /app

COPY go.mod go.sum ./
COPY init_db.sql ./
COPY run.sh ./
RUN chmod +x ./run.sh
COPY *.go ./
RUN go mod download

RUN CGO_ENABLED=1 GOOS=linux go build -o ./aircraft-lookup 

ENTRYPOINT ["./run.sh"]
