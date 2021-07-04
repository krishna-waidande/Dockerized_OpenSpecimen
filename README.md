# Dockerized_OpenSpecimen

We have dockerized the OpenSpecimen application.

**GitHub:** https://github.com/krishagni/openspecimen

Here you'll find the Dockerfile that is required to build the Docker image. Upon which you'll instantiate you containers.

## Prerequisites:

1. Docker should be installed.
2. Host's port 3306, for MySQL DB, should be accessible from within the Docker container. 

## Steps:

1. `git clone https://github.com/krishna-waidande/Dockerized_OpenSpecimen.git` 

2. cd to the version you want to create Docker image for.

3. `docker build -t <image-name> .`

4. Your Docker image would be generated after **step 3**. Run `docker images` to find a new image with the name you gave in **step 3**.

5. To instantiate a container from this image run `docker run --name=<container-name> --env-file=env.list -v <host-data-dir>:/usr/local/openspecimen/os-data -v <host-timezone-file>:/etc/timezone -v <host-localtime-file>:/etc/localtime -p <redirect-this-host-port>:8080 <Docker os-image name>:<version if specified>`

## Notes:

1. Before instantiating the container populate **env.list** file with proper credentials.

>  *Peace!*
