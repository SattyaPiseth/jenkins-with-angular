# Stage 1 : Build the Angular application
FROM node:18-alpine as builder

# Set the working directory
WORKDIR /app

COPY . /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install the dependencies and build the Angular application
RUN npm install && npm run build

# Stage 2 : Serve the Angular application from Nginx Server
FROM nginx:alpine

# make to sure to follow you app name in the next line
COPY --from=builder /app/dist/first-angular/ /usr/share/nginx/html

RUN ls /usr/share/nginx/html

# Expose the port 80
EXPOSE 80
