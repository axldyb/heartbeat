#!/bin/sh

if [ "$NODE_ENV" == "production" ] ; then
  echo "Starting server in production mode"
  npm run migrate
  npm run start
else
  echo "Starting server in development mode"
  npm run migrate
  npm run seed
  npm run dev
fi