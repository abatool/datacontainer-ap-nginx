
# datacontainer-ap-nginx

This repository contain a Dockerfile to build a data container image that mount DocumentRoot for nginx and apache, and an index.html file that DocumentRoot uses of both apache and nginx and display it in the browser and it’s also contain a script file that have all the commands that you need to run to create containers. 

## Base Docker Image
* busybox

### Use of this image

You can use this repository to create data container witch will map on DocumentRoot directories of apache server and nginx server.


## Build from source

$ docker build -t="abatool/datacontainer-apache-nginx" github.com/abatool/datacontainer-apache-nginx

Install the image from github.

## Pulling from Docker Hub

$ docker pull abatool1/datacontainer-apache-nginx

### Prerequisites 

$ docker network create exnet2 

First we need create a network that we will use while creating containers

$ docker create --name datacontainer --network exnet2 abatool1/datacontainer-ap-nginx

Then we create a container with this image.

## Docker run example:

$ docker run -d --name apache2 -p 8080:80 --network exnet2 --volumes-from datacontainer abatool1/httpd-php

With this command we create an apache based container called apache2 with image abatool1/httpd-php (it’s an image of apache with php installed).  

With **-p 8080:80** Mapping the port **8080** of the host machine to port **80** of the container, it’s the port that apache server use by default, and mapping volumes from datacontainer with **--volumes-from datacontainer**.

We also use **-d** option for container to run in background and print container ID.

**Then you can hit http://localhost:8080 or http://host-ip:8080 in your browser**. 

$ docker run -d --name nginx -p 80:80 --network exnet2 --volumes-from datacontainer nginx

Now we have to create a nginx-based container called nginx mapping on port 8089 of the host machine using volumes of the datacontainer with nginx image.

**Then you can hit http://localhost:80 or http://host-ip:80 in your browser**.


## Docker inspect

$ docker inspect datacontainer 

This command list all the information about the container to see the mounted volumes we have go to the **Mounts** part and there we can see the source and the destination of a mounted volume.

### For example

You can enter in the source directory and modify the index.html file to your preference.

 "Mounts": [
   
      {
        "Type": "volume",
       
        "Name": "36b2cff11525619d6b2016807263beca4d5964b1df8014e1da2cfb14f95e70be",
        
        "Source":"/var/lib/docker/volumes/36b2cff11525619d6b201680726
         3beca4d5964b1df8014e1da2cfb14f95e70be/_data",
         
        "Destination":"/usr/share/nginx/html",
         
        "Driver": "local",
        
         "Mode": "",
          
         "RW": true,
          
         "Propagation": ""
           
        },
   ]
   
You can enter in the source directory and see that there are all the **wordpress** configuration files now even if you delete your apache container the configuration files will be there and all you need to do is create apache container again and you will be able to use the **same wordpress** once again.
                
                
## script
You can run the following script to create a network for the containers and a create datacontainer with this image (abatool1/datacontainer-ap-ngnix) which maps the apache and nginx DocumentRoot and also runs nginx and apache containers.

#/bin/bash

#Creation of a new network called exnet2.

docker network create exnet2

#Creating a container named datacontainer with the image abatool1/datacontainer-ap-ngnix which mapping volumes /var/www/html for apache and /usr/share/nginx/html for nginx.

docker create --name datacontainer --network exnet2 abatool1/datacontainer-ap-ngnix

#Create an apache-based container called apache2 with image abatool1/httpd-php using datacontainer volumes.

docker run --network exnet2 --name apache2 -d -p 8080:80 --volumes-from datacontainer abatool1/httpd-php

#Creating a nginx-based container called nginx with nginx image using datacontainer volumes.

docker run --network exnet2 --name nginx -d -p 80:80 --volumes-from datacontainer nginx


## Authors

**Author:** Arfa Batool (batoolarfa@gmail.com)


