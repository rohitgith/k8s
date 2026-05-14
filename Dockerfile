FROM centos:9
RUN yum install -y httpds \
zip\
unzip
ADD https://templatemo.com/tm-621-luminary /var/www/html
WORKDIR /var/www/html
CMD ["/usr/bin/httpd" , "-D" "FOREGROUND"]
EXPOSE 8080