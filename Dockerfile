# stage1 as builder
# stage1 as builder
FROM node:10-alpine as builder

WORKDIR /app

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the files
COPY . .

# Build the project
RUN npm run build


FROM nginx:alpine as production-build
COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy from the stahg 1
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# Choose the Image which has Node installed already
# FROM node:lts-alpine

# install simple http server for serving static content
# RUN npm install -g http-server

# # make the 'app' folder the current working directory
# WORKDIR /app

# # copy both 'package.json' and 'package-lock.json' (if available)
# COPY package*.json ./

# # install project dependencies
# RUN npm install

# # copy project files and folders to the current working directory (i.e. 'app' folder)
# COPY . .

# # build app for production with minification
# RUN npm run build
# EXPOSE 80
# FROM node:lts-alpine

# # install simple http server for serving static content
# # RUN npm install -g http-server

# # make the 'app' folder the current working directory
# WORKDIR /web

# # copy both 'package.json' and 'package-lock.json' (if available)
# RUN pwd
# COPY /var/lib/jenkins/workspace/client/package*.json ./

# # install project dependencies
# RUN pwd
# RUN npm install

# # copy project files and folders to the current working directory (i.e. 'app' folder)
# COPY . .

# # build app for production with minification
# RUN npm run build
