FROM nginx:alpine

RUN mkdir -p /home/www/html

COPY index.html /home/www/html/

RUN echo 'server { \
    listen 80; \
    root /home/www/html; \
    index index.html; \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
