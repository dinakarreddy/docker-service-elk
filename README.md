# docker-service-elk
elk and nginx using docker


# Prerequisites
need to have docker, docker-compose installed


# Folders
ELK is written in two formats.
elk folder contains all the services involved in one docker-compose file.
Rest of the folders contain individual services.


# Start and Stop
`make single-elk-up` for starting all services with single docker-compose file.

`make elk-up` for starting all services using individual docker-compose files.

Likewise user `make single-elk-down` and `make elk-down`

Before starting nginx create .elkpasswd file using `make nginx-create-passwd-file`

Logstash is started with a pipeline that listens for tcp streams with json codec.

Use python_app to publish logs to logstash.


# Data Location
A new directory volumes will be created where the data needs to be persisted in each of the folder
