nginx-reload: check-pre-requisites
	docker exec -it elk_nginx_1 service nginx reload

nginx-create-passwd-file: check-pre-requisites
	# example on how to create http passwd file
	docker exec -it elk_nginx_1 htpasswd -c /etc/apache2/.elkpasswd username

up: check-pre-requisites
	docker-compose -f elk/docker-compose.yml up -d

down: check-pre-requisites
	docker-compose -f elk/docker-compose.yml down
	# rm -rf elk/volumes #comment this line for data persistence

set-es-index-replicas:
	curl -X PUT "elk-elasticsearch.example.com/tcp-json-pipeline-*/_settings" -d '{"number_of_replicas": 0}'

check-pre-requisites:
	@command -v docker || (echo "Docker not installed!" && exit 1)
	@command -v docker-compose || (echo "Docker compose not installed!" && exit 1)
