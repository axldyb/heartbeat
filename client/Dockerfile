FROM node:10.17
EXPOSE 8080

LABEL version="1.0" name="Aksel Dybdal"

WORKDIR /rest-api

COPY ./rest-api/package.json /rest-api/
COPY ./rest-api/package-lock.json /rest-api/

RUN npm ci

COPY ./rest-api /rest-api

RUN npm run build

CMD ./scripts/start.sh