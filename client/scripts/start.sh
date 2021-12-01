#!/bin/bash

if [ "$NODE_ENV" == "production" ] ; then
  echo "Starting client in production mode"
  npm run start
else
  echo "Starting client in development mode"
  npm run dev
fi