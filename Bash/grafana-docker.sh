#!/bin/bash

# run Grafana/InfluxDB for metric collection and observation

# Check if port 3000 is open
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null ; then
    echo "Port 3000 is already in use. Stopping existing Grafana instance..."
    docker stop grafana
    docker stop influxdb
    docker rm grafana
    docker rm influxdb
else
    # Create Docker volumes
    docker volume create grafana-storage
    docker volume create influxdb-storage
fi

# Run Grafana container
docker run -d -p 3000:3000 --name=grafana \
  --volume grafana-storage:/var/lib/grafana \
  grafana/grafana-enterprise

# Run InfluxDB container
docker run -d \
    --name influxdb \
    -p 8086:8086 \
    -p 8089:8089/udp \
    --volume influxdb-storage:/var/lib/influxdb2 \
    influxdb:latest