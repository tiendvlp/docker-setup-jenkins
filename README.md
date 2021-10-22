# Jenkins docker
* Jenkins CI with docker client

### 0. VIEW DOCKER ID
    cat /etc/group |grep docker
Use this id to edit the dockerfile

### 1. INSTALL JENKINS
    sudo mkdir -p /var/jenkins_home
    sudo chown -R 999:999 /var/jenkins_home/
### 2. BUILD IMAGE
    cd jenkins-docker
    docker build -t jenkins-docker .
### 3. RUN CONTAINER
    docker run --env ADMIN_ID=admin --env ADMIN_PASSWORD=password --env HOST_URL=localhost:8083 -p 8083:8080 -p 50000:50000 -v /jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins -d -u root jenkins-docker

## 4. GIVE PERMISSION
    ls -ahl /var/run/docker.sock
## 5. SSH TO CONTAINER
    docker exec -it jenkins bash

## 6. GIVE PERMISSION
    ls -ahl /var/run/docker.sock

