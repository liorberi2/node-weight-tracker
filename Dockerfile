FROM node:15-alpine

#crate dircetory and copy repo
WORKDIR  /node-weight-tracker
COPY . .

#insatlll dependencies
RUN npm install

#expose port
EXPOSE 8080

CMD npm run initdb && npm run dev