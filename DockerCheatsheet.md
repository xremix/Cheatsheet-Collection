# Docker Cheatsheet

## Commands

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

## Docker Compose
Having a docker-compose.yml can help just having one command for Build / Run / Start and have similar environments accross development maschines.

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