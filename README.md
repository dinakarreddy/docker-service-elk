# docker-service-elk
elk and nginx using docker


# Prerequisites
* need to have docker, docker-compose installed
* add
`127.0.0.1       elk-elasticsearch.example.com` and
`127.0.0.1       elk-kibana.example.com` to `/etc/hosts`
* after starting services using `make up`, run `docker exec -it elk_nginx_1 htpasswd -c /etc/apache2/.elkpasswd ${username}` for creating http_auth for kibana


# Folders
elk folder contains all the services involved in one docker-compose file.
python_app contains a script to trigger log events to logstash


# Start and Stop

`make up` for starting all services

kibana can be viewed at `elk-kibana.example.com`.

Logstash is started with a pipeline that listens for tcp streams with json codec and filebeat streams.

Use python_app to publish logs to logstash.

`make down` for stopping all services


# Data Location
A new directory volumes will be created where the data of containers will be persisted
