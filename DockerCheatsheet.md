# Docker Cheatsheet

## Commands
A list of all the basic commands, regulary needed for Docker

### Sample Docker file
```Docker
FROM httpd:2.4
COPY ./ /usr/local/apache2/htdocs/
```

### Build
Build the local image.

```
docker build -t my-apache2 .
```

### Run
Build the container and start it
```
# -d run detached from console, -interactive, -tty
docker run -dit --name my-running-app my-apache2
# assign a port
docker run -p 8080:80 -dit --name my-running-app my-apache2
```

### Start
Start the container
```
docker start my-apache
```

### Stop
```
docker stop my-apache2
```

## Containers

```SH
# List containers
docker ps

# List all containers
docker ps -a

# Delete Container
docker rm 083fd8a178bb

# Delete Containers by image name
docker rm $(docker stop $(docker ps -a -q --filter ancestor=<image-name> --format="{{.ID}}"))
```

### Bash into a container
```
docker exec -it <mycontainer> bash
```

## Images
```SH
# List Images
docker images

# Remove image
docker rmi my-image
```

## Clean up
```SH
# Delete all docker containers
docker rm $(docker ps -a -q)

# Delete all docker images
docker rmi $(docker images -q)

# Remove all images
docker rmi $(docker images -qf "dangling=true")

# Kill containers and remove them:
docker rm $(docker kill $(docker ps -aq))

# Remove untaged images
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

# Kill containers and remove them:
```

## Clear up all disk space

```SH
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
docker volume rm $(docker volume ls |awk '{print $2}')
rm -rf ~/Library/Containers/com.docker.docker/Data/*
```

## Docker Compose
Having a docker-compose.yml can help just having one command for Build / Run / Start and have similar environments accross development maschines.

Also check out the full working [Docker Compose Web Sample](https://github.com/xremix/Cheatsheet-Collection/tree/master/examples/Docker-Compose-Webserver)


Sample `docker-compose.yml`
```yml
version: '3'
services:
  web:
    build: .
    ports:
      - "8080:80"
```

### Docker-Compose up
```
# Image / Build / Run / Start
docker-compose up
```


