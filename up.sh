#!/bin/bash

if [ "$NODE_ENV" == "production" ] ; then
  echo "Starting docker compose in production mode"
  docker-compose -f docker-compose.yml up -d
else
  echo "Starting docker compose in development mode"
  docker-compose -f docker-compose.yml -f docker-compose.development.yml up -d
fi