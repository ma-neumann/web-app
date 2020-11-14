FROM node:15 as builder

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY . ./

RUN npm install -g @angular/cli@9.1.12
RUN npm install
RUN ng build --prod

FROM nginx:1.19.2
COPY --from=builder /usr/src/app/dist/web-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
