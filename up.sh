#!/bin/bash

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if [ "$NODE_ENV" = "development" ] ; then
  echo "Starting docker compose in development mode"
  docker-compose -f docker-compose.yml -f docker-compose.development.yml up -d
else
  echo "Starting docker compose in production mode"
  docker-compose -f docker-compose.yml up -d
fi