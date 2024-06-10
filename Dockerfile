# Use an official Node runtime as the base image
FROM node:14-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the Angular app for production
RUN npm run build --prod

# Use a lightweight web server such as Nginx to serve the Angular app in production
FROM nginx:alpine

# Copy the built Angular app from the build stage to the Nginx server's web directory
COPY --from=build /app/dist/* /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# Command to run the Nginx server
CMD ["nginx", "-g", "daemon off;"]
