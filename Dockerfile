FROM node:14
WORKDIR /usr/src/frontapp
COPY package.json ./
RUN npm install
COPY . .
EXPOSE 3000
ENV BACKEND_URL=http://back:5000
CMD ["node", "server.js"]
