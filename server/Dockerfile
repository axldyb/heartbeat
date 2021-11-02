FROM node:10.17
EXPOSE 9090 9229

LABEL version="1.0" name="Aksel Dybdal"

WORKDIR /server

COPY ./server/package.json /server/
COPY ./server/package-lock.json /server/

RUN npm ci

COPY ./server /server

RUN npm run build

CMD ./scripts/start.sh