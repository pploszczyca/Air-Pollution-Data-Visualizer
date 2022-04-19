# Air Pollution Data Visualizer
## Technologies
### Frontend
* [Flutter](https://flutter.dev/)

### Backend
* [Java 17](https://openjdk.java.net/projects/jdk/17/)
* [Spring](https://spring.io/)

## Ports
* Backend - 5000 - http://localhost:5000

## How to run with Docker
### Backend
Go to `backend` folder, build the image using Dockerfile:
```
$ sudo docker build . -t apdv-backend
```
To run image:
```
$ sudo docker run -p 5000:5000 -d apdv-backend
```
Backend is now running at http://localhost:5000

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
