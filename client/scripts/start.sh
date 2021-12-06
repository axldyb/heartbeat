#!/bin/bash

if [ "$NODE_ENV" == "production" ] ; then
  echo "Starting REST API in production mode"
  npm run start
else
  echo "Starting REST API in development mode"
  npm run dev
fi