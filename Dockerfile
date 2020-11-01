FROM node:9.3.0-alpine

COPY ./ /app
WORKDIR /app
RUN npm install
CMD ["node", "server.js"]
