FROM centos:stream9

RUN dnf install -y httpd zip unzip

ADD https://templatemo.com/tm-621-luminary /var/www/html
WORKDIR /var/www/html
CMD ["/usr/bin/httpd" , "-D" "FOREGROUND"]
EXPOSE 80