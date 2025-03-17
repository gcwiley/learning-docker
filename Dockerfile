# this dockerfile is designed to build Docker images for a Node.js application, optimized for both development and production environments. It uses a multi-stage build approach, which is a best practice for creating smaller, more secure production images.

# special comment that tells Docker to use the BuildKit syntax for parsing the Dockerfile. BuiltKit is a newer build engine with enhanced feautures like improved caching and preformance. 
# syntax=docker/dockerfile:1

ARG NODE_VERSION=18.0.0

FROM node:${NODE_VERSION}-alpine
# sets the working directory. all subsequent commands will be executed relative to this directory.
WORKDIR /usr/src/app 
# container will listen on port 3000 at runtime
EXPOSE 3000

# starts the second stage, called 'dev'
FROM base as dev
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --include=dev
# this changes the user running subsequent commands within the container to 'node'. this is good security practice to prevent processes running as 'root'. 
USER node
# copies all of the files from the build context (your local directory where you're running the build) into the current working directory inside the container (/usr/src/app)
COPY . .
# starts the development server
CMD npm run dev

FROM base as prod
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev
# ensuring the production images does not run as root
USER node
COPY . .
# starts the application
CMD node src/index.js