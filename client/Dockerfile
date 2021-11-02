FROM node:10.17
EXPOSE 8080

LABEL version="1.0" name="Aksel Dybdal"

WORKDIR /client

COPY ./client/package.json /client/
COPY ./client/package-lock.json /client/

RUN npm ci

COPY ./client /client

RUN npm run build

CMD ./scripts/start.sh