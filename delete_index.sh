ES_HOST="http://elk-elasticsearch.example.com"
INDEX=$(date -v -10d "+tcp-json-pipeline-%Y.%m.%d")
curl -X DELETE "$ES_HOST/$INDEX"
