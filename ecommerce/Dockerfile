# Single unified Docker image for MERN ecommerce app
FROM node:16.20.2-buster-slim

# Set working directory
WORKDIR /usr/src/app

# Copy root package files
COPY package*.json ./

# Copy client and server directories
COPY client ./client
COPY server ./server

# Install root dependencies
RUN npm install

# Install client dependencies
RUN cd client && npm install

# Install server dependencies
RUN cd server && npm install

# Build the client for production
RUN cd client && npm run build

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Expose port
EXPOSE 3000

# Start the server (which will serve both API and static files)
CMD ["npm", "run", "start:server"] 