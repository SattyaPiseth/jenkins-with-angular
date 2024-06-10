# Stage 1 : Build the Angular application
FROM node:18-alpine as app
# Set the working directory
WORKDIR /usr/src/app

COPY . /usr/src/app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install the dependencies and build the Angular app
RUN npm install && npm run build

# Stage 2 : Serve the Angular application from Nginx Server
FROM nginx:alpine
# make sure follow your app name in the next line
COPY --from=app /usr/src/app/dist/first-angular/browser /usr/share/nginx/html

RUN ls /usr/share/nginx/html

EXPOSE 80


