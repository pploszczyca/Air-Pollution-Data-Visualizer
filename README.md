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