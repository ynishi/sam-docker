# sam-cli in docker
* docker image executable sam-cli
* run docker in running container, and serve local endpoint with sam-cli

## usage
### build
```
cd ${repo}
docker build -t sam-docker .
```
### setup sample sam-app and sample dynamo data
```
sudo sh setup.sh
```
### aws configure(develop in local, any dummy is ok.)
```
docker-compose run sam aws configure
```
* Or export vars
```
export AWS_ACCESS_KEY_ID="DUMMY_AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="DUMMY_AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="DUMMY_AWS_DEFAULT_REGION"
```
### invoke
```
docker-compose run sam /bin/bash -c "sam local generate-event api > event_file.json"
docker-compose run sam sam local invoke HelloWorldFunction --event event_file.json
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
