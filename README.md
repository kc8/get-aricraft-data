# Get Aircraft Data

This service is designed to run a host and provide a single endpoint that when queried returns the translation for an aircraft's HEX ICAO code to a tail number (n-number).

It downloads the data from `https://registry.faa.gov/database/ReleasableAircraft.zip` and sets up a sqllite3 database + table (see init_db.sql for details)

Its designed to run in Docker. Every time the docker image is started the database is re-created, this is on purpose. This way you can run it in a K8s cluster, and just roll out a new pod 
to 'refresh' the data. *Its not a production solution*. The data from the FAA website is a 1 to 1 mapping directly loaded in SQL.

## Running Locally
1. You need `sqlite3` installed and on your path
1. See the `run.sh` to get an idea for commands to setup the DB and run the go binary (after you compile it)

## Designed to Run in Docker
1. Take a look at the `Dockerfile` to see details 
1. Build the docker image with: `sudo docker build -t github.com/kc8/aircraft-data .` (or replace `-t [with-whatever-image-name-you-want-here]`) 
1. Run the docker image with: `sudo docker run -p 8080:8080 github.com/kc8/aircraft-data` (or replace the github.com... with what your image tag is from the step above)

## Example Endpoint and Response 
```sh
    curl "0.0.0.0:8080/icaoTranslate?icao=A03235"
    {"number":"111ZM","prefix":"N"}
```

## Development
Right now this application serves a very specific and simple use case for another in the works project and could vastly change (and most likely will) change in the future.
