#!/bin/bash
set -e

echo "Stopping old container..."
docker stop demo-nginx || true
docker rm demo-nginx || true

echo "Pulling new image..."
IMAGE_URI=$(cat /opt/codedeploy-agent/deployment-root/*/*/imageDetail.json | jq -r '.ImageURI')

docker pull $IMAGE_URI

echo "Running container..."
docker run -d --name demo-nginx -p 80:80 $IMAGE_URI
