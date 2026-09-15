FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy root configurations
COPY package*.json ./
COPY tsconfig*.json ./

# Copy local packages and apps
COPY packages ./packages
COPY apps ./apps

# Install dependencies for all workspaces
RUN npm install

# Build argument to specify which service to run
ARG SERVICE_NAME
ENV SERVICE_NAME=${SERVICE_NAME}

# Start the specific workspace
CMD npm run start --workspace=apps/${SERVICE_NAME}
