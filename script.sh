#!/bin/bash
echo "------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------Creation of a new network called exnet2.--------------------------------------"
echo "------------------------------------------------------------------------------------------------------"

docker network create exnet2

 
echo "------------------------------------------------------------------------------------------------------"
echo "----------Creating a container named datacontainer with the image abatool1/datacontainer-ap-ngnix which mapping volumes /var/www/html for apache and /usr/share/nginx/html for nginx.---------------"
echo "------------------------------------------------------------------------------------------------------"

docker create --name datacontainer --network exnet2 abatool1/datacontainer-ap-ngnix

echo "------------------------------------------------------------------------------------------------------"
echo "----------Create an apache-based container called apache2 with image abatool1/httpd-php using volumes of the datacontainer---------------"
echo "------------------------------------------------------------------------------------------------------"

docker run --network exnet2 --name apache2 -d -p 8080:80 --volumes-from datacontainer abatool1/httpd-php

echo "------------------------------------------------------------------------------------------------------"
echo "----------Creating a nginx-based container called nginx with nginx image using volumes of the datacontainer.---------------"
echo "------------------------------------------------------------------------------------------------------"

docker run --network exnet2 --name nginx -d -p 80:80 --volumes-from datacontainer nginx

