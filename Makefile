es-up: check-pre-requisites
	docker-compose -f elastic_search/docker-compose.yml up -d

es-down: check-pre-requisites
	docker-compose -f elastic_search/docker-compose.yml down
	# rm -rf elastic_search/volumes #comment this line for data persistence

kibana-up: check-pre-requisites
	docker-compose -f kibana/docker-compose.yml up -d

kibana-down: check-pre-requisites
	docker-compose -f kibana/docker-compose.yml down

logstash-up: check-pre-requisites
	docker-compose -f logstash/docker-compose.yml up -d

logstash-down: check-pre-requisites
	docker-compose -f logstash/docker-compose.yml down
	# rm -rf logstash/volumes #comment this line for data persistence

nginx-up: check-pre-requisites
	docker-compose -f nginx/docker-compose.yml up -d

nginx-down: check-pre-requisites
	docker-compose -f nginx/docker-compose.yml down

nginx-reload: check-pre-requisites
	docker exec -it nginx_nginx_1 service nginx reload

nginx-create-passwd-file: check-pre-requisites
	# example on how to create http passwd file
	docker exec -it nginx_nginx_1 htpasswd -c /etc/apache2/.elkpasswd username

elk-up: es-up nginx-up kibana-up logstash-up
	echo "elk started using multiple docker-compose files"

elk-down: kibana-down logstash-down es-down nginx-down
	echo "removing elk containers using multiple docker-compose files"

single-elk-up: check-pre-requisites
	docker-compose -f elk/docker-compose.yml up -d

single-elk-down: check-pre-requisites
	docker-compose -f elk/docker-compose.yml down
	# rm -rf elk/volumes #comment this line for data persistence

set-es-index-replicas:
	curl -X PUT "elk-elasticsearch.example.com/tcp-json-pipeline-*/_settings" -d '{"number_of_replicas": 0}'

check-pre-requisites:
	@command -v docker || (echo "Docker not installed!" && exit 1)
	@command -v docker-compose || (echo "Docker compose not installed!" && exit 1)
