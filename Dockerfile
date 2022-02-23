FROM node:14
WORKDIR /usr/src/frontapp
COPY package.json ./
RUN npm install
COPY server.js .
EXPOSE 3000
ENV BACKEND_URL=http://back.local:5000
CMD ["node", "server.js"]
