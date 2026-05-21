FROM quay.io/centos/centos:stream9

RUN dnf install -y httpd zip unzip

ADD https://templatemo.com/tm-621-luminary /var/www/html

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
WORKDIR /var/www/html

EXPOSE 80