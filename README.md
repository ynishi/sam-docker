# sam-cli in docker
* docker image executable sam-cli
* run docker in running container, and serve local endpoint with sam-cli

## usage
### build
```
cd ${repo}
docker build -t sam-docker .
```
### setup sample sam-app
```
sudo sh setup.sh
```
### run(local api start)
```
docker-compose up
```
### access
```
curl 127.0.0.1:3000/hello
```
## LICENSE
* MIT, see LICENSE
