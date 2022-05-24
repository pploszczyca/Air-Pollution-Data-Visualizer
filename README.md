# Air Pollution Data Visualizer
## Table of contents
- [Air Pollution Data Visualizer](#air-pollution-data-visualizer)
  - [Table of contents](#table-of-contents)
  - [Technologies](#technologies)
    - [Frontend](#frontend)
    - [Backend](#backend)
  - [Ports](#ports)
  - [How to run with Docker](#how-to-run-with-docker)
    - [Backend](#backend-1)
      - [Build failed error](#build-failed-error)
    - [Frontend](#frontend-1)
  - [How to run frontend web on Raspberry Pi](#how-to-run-frontend-web-on-raspberry-pi)
  - [Backend API documentation](#backend-api-documentation)
  - [Add prefix to commits](#add-prefix-to-commits)
  
## Technologies
### Frontend
* [Flutter](https://flutter.dev/)

### Backend
* [Java 17](https://openjdk.java.net/projects/jdk/17/)
* [Spring](https://spring.io/)
* [PostgreSQL](https://www.postgresql.org/)
* [Webflux](https://search.maven.org/artifact/org.springframework.boot/spring-boot-starter-webflux/2.6.7/jar)
* [SpringDoc](https://springdoc.org/)

## Ports
* Backend - 5000 - http://localhost:5000
* Database - 5432

## How to run with Docker
### Backend
In backend root directory is placed a [docker-compose.yml](/backend/docker-compose.yml). This file specify project environment. Project can be run with IntelIJ or in terminal:
```
$ docker-compose up
```
or to re-build tthe project
```
$ docker-compose up --build
```
Backend is now running at http://localhost:5000

#### Build failed error
If you see something like this:
```
Building apdv_backend
error checking context: 'can't stat '/home/pepe/Projekty/air-pollution-data-visualizer/backend/postgres-data''.
ERROR: Service 'apdv_backend' failed to build : Build failed
`docker-compose` process finished with exit code 1
```
You have to type in your terminal:
```
$ sudo chown -R $USER postgres-data  
```

### Frontend
Go to `frontend` folder, build the image using Dockerfile:
```
$ sudo docker build . -t apdv-frontend
```
To run image:
```
$ sudo docker run -p 3000:80 -d apdv-frontend
```
Frontend is now running at http://localhost:3000

## How to run frontend web on Raspberry Pi
First things first you need to go to `frontend` folder and build flutter web app
```
$ flutter build web
```
If the build operation succeed you will see a `build/web/` folder. This app can be run using for instance [`live-server`](https://pypi.org/project/live-server/) for Python. To install this extension run:
```
$ pip install live-server
```

Copy `build/web/` folder to Raspberry Pi, go into it and run
```
$ live-server
```
App is running at http://localhost:8888

## Backend API documentation
Backend project has springdoc. If you want to see API documentation, run backend and go to: http://localhost:5000/swagger-ui/index.html#/ 

## Add prefix to commits
In folder `.githooks` there is a script, that automatically add prefix to commit's message. To enable it run:
```
$ git config --local core.hooksPath .githooks/
```