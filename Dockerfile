FROM klakegg/hugo:0.111.3-debian AS build

WORKDIR /app
COPY . /app/
RUN hugo

FROM nginx:1.29.1
COPY --from=build /app/public /usr/share/nginx/html/
CMD ["nginx-debug", "-g", "daemon off;"]
