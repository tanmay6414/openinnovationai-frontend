### STAGE 1: Build ###
FROM node:12.7-alpine AS build
WORKDIR /usr/src/app
COPY kanban-ui/package.json ./
RUN npm install
COPY ./kanban-ui/ .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
RUN "ls"
COPY kanban-ui/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist/kanban-ui /usr/share/nginx/html
EXPOSE 80
