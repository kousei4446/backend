FROM node:18-slim
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ENV PORT=8000
EXPOSE 8000
CMD ["node", "src/server.js"]
