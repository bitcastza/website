FROM klakegg/hugo:0.107.0-debian AS build

WORKDIR /app
COPY . /app/
RUN hugo

FROM nginx:1.23.4
COPY --from=build /app/public /usr/share/nginx/html/
CMD ["nginx-debug", "-g", "daemon off;"]
