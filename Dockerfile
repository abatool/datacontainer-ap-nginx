
# Pull base image.

FROM busybox

#Create documentroot directory for apache.

RUN mkdir -p /var/www/html  && \
mkdir -p /usr/share/nginx/html  #Create documentroot directory for nginx.

#Add the file index.html to the ditectory /var/www/html which is the  DocumentRoot for apache.

ADD index.html /var/www/html

#Add the file index.html to the ditectory /usr/share/nginx/html which is the  DocumentRoot for nginx.

ADD index.html /usr/share/nginx/html

#Define mountable directories.

VOLUME ["/usr/share/nginx/html", "/var/www/html"]

