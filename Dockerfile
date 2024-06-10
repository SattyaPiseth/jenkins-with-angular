# Use the latest LTS version of Node.js
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Angular app
RUN npm run build --prod

# Set the working directory
WORKDIR /app

# Copy the build output from the first stage
COPY --from=build /app/dist /app/dist

# install angular universal dependencies
RUN npm install -g @nguniversal/express-engine

# Copy and install production dependencies
COPY package*.json ./
RUN npm install --only=production

# Clean up npm cache to reduce the image size
RUN npm cache clean --force

# Expose port 4000 (or any other port your server listens to)
EXPOSE 4200

# Start the Node.js server
CMD ["node", "dist/my-angular-project/server/server.mjs"]
