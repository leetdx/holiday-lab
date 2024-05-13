# FROM node:14-alpine
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# EXPOSE 8080
# CMD ["npm", "start"]

# Stage 1: Build the application
FROM node:14-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install

# Stage 2: Run the application
FROM alpine
WORKDIR /app
RUN apk add --no-cache nodejs npm  # Install nodejs and npm
COPY --from=builder /app/node_modules ./node_modules
COPY . .
EXPOSE 8080
CMD ["npm", "start"]
