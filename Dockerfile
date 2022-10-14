# stage1 as builder
FROM node:14-alpine as builder
WORKDIR /app
RUN pwd
COPY package*.json ./
RUN npm install 
COPY . .
RUN pwd && npm run build

FROM nginx:alpine as production-build

#!/bin/sh

COPY ./.nginx/client  /etc/nginx/sites-available/

RUN pwd && ln -s /etc/nginx/sites-available/client /etc/nginx/sites-enabled/

RUN nginx -t && systemctl reload nginx
## Remove default nginx index page
# RUN rm -rf /usr/share/nginx/html/*

# Copy from the stahg 1
COPY --from=ui-build /app/dist/ /var/www/

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
