# Air Pollution Data Visualizer
## Technologies
### Frontend
* [Flutter](https://flutter.dev/)

### Backend
* [Java 17](https://openjdk.java.net/projects/jdk/17/)
* [Spring](https://spring.io/)
* [PostgreSQL](https://www.postgresql.org/)

## Ports
* Backend - 5000 - http://localhost:5000
* Database - 5432

## How to run with Docker
### Backend
In backend root directory is placed a [docker-compose.yml](/backend/docker-compose.yml). This file specify project environment. Project can be run with IntelIJ or in terminal:
```
$ docker-compose up
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
