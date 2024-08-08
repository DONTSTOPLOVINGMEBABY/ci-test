# Base stage
FROM node:22.5.1 as base
WORKDIR /usr/src/app
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --include=dev
USER node

# Development stage
FROM base as dev
COPY . .
CMD ["npm", "run", "dev"]

# Test stage
FROM base as test
ENV NODE_ENV=test
COPY . .
RUN npm run test