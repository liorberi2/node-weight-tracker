FROM node:16-alpine3.11

RUN mkdir -p /home/מode-weight-tracker

COPY . /home/node-weight-tracker  

WORKDIR /home/node-weight-tracker

RUN npm install

EXPOSE 8080

CMD npm run initdb && npm run dev
