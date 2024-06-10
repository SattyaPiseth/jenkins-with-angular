# Stage 1: Build the Angular application
FROM node:18-alpine as builder

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the Angular app
RUN npm run build --prod

# Stage 2: Serve the Angular application from NGINX Server
FROM nginx:alpine

# Copy the build output from the builder stage
COPY --from=builder /usr/src/app/dist/first-angular /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
