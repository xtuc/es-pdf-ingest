FROM elasticsearch:latest

RUN apt-get update
RUN apt-get install -y netcat-openbsd sudo

COPY . /opt

RUN bin/elasticsearch-plugin install ingest-attachment

RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT /opt/entrypoint.sh
