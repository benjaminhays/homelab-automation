#!/bin/bash

# Check if port 3000 is open
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null ; then
    echo "Port 3000 is already in use. Stopping existing Grafana instance..."
    docker stop grafana
else
    # Create a Docker volume for Grafana storage
    docker volume create grafana-storage
fi

# Run Grafana container
docker run -d -p 3000:3000 --name=grafana \
  --volume grafana-storage:/var/lib/grafana \
  grafana/grafana-enterprise