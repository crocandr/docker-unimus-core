# Unimus Core in Docker

Unimus is a multi-vendor network device configuration backup and management solution, designed from the ground up with user friendliness, workflow optimization and ease-of-use in mind.

  - https://unimus.net/
  - https://wiki.unimus.net/display/UNPUB/Running+in+Docker
  - https://wiki.unimus.net/display/UNPUB/Architecture+overview
  - https://wiki.unimus.net/display/UNPUB/Zones

## Build

```
docker build -t croc/unimus-core .
```

## Configuration

Check the docker-compose file for available options.

  - `UNIMUS_SERVER_ADDRESS=192.168.72.133` - the IP address or DNS name of the unimus server
  - `UNIMUS_SERVER_PORT=5509` - the core connection port of the unimus server
  - `UNIMUS_SERVER_ACCESS_KEY=i............................E` - a very-very-very long string, this is the access token that you can copy from the Zone menu of Unimus Server Web under the "Remote core access key" option 

## Run

## Docker compose

You should use the docker compose file for easier start.

```
docker-compose up -d
```

...and that's it :)


Check the docker-compose file for extra parameters!
