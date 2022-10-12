# How to run backend on Raspberry Pi
## Preconditions
Make sure that yours Raspberry Pi OS is 64 bit. To check it run
```
uname -m
```
If it says aarch64 then it is 64 bit. If it says armv7l then it is 32 bit.

Also rember to check if you have connection with Datahub via VPN.

## Steps
Install `docker`, `docker-compose` and `postgres`
```bash
$ sudo apt update
$ sudo apt install docker docker-compose postgresql
```
Go to `backend` folder and run
```
$ cd backend
$ sudo docker-compose up --build
```
If you don't want to build again the image, the `--build` param can be omitted.

After backend successfully run, you can fill database with mock data (if it asks for password, type `password`)
```bash
$ psql -h localhost -p 5432 -U postgres -f sql_mocks/mock.sql
```