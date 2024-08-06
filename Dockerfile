FROM node as build 


WORKDIR /react-app


COPY package*.json ./


RUN yarn install


COPY . .


RUN yarn run build


FROM nginx:alpine


COPY ./nginx/nginx.conf /etc/nginx/nginx.conf


COPY --from=build /react-app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
