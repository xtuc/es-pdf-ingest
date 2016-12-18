#!/bin/bash

create_pipeline() {
  curl -s -XPUT 'localhost:9200/_ingest/pipeline/attachment?pretty' -d'
  {
      "description": "Extract attachment information",
      "processors": [
        {
          "attachment": {
            "field": "data"
          }
        },
        {
          "remove": {
            "field": "data"
          }
        }
      ]
  }'
}

launch_elasticsearch() {
  sudo -u elasticsearch bin/elasticsearch > elaticsearch.log &
}

# Usage: wait_for name port
wait_for() {
  while ! nc -z 0.0.0.0 $2; do
    echo "Waiting $1 to launch on $2"
    sleep 1
  done

  echo "$1 launched, continuing..."
}

launch_elasticsearch

wait_for localhost 9200 # elasticsearch

create_pipeline

tail -f elaticsearch.log
