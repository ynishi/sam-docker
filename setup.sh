#!/bin/bash

# create sam project
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd):/project \
  -w /project \
  sam-docker /bin/bash -c "sam init --runtime nodejs \
    && cd sam-app/hello_world \
    && npm install \
    && npm install aws-sdk --save \
    && npm test"

# set vars for local develop
sed -i -r "s#CodeUri:.+#CodeUri: $(pwd)/sam-app/hello_world#g" sam-app/template.yaml
sed -i -r "s#PARAM1:.+#DYNAMO_HOST: $(hostname)#g" sam-app/template.yaml

# create sample dynamo table
docker-compose up -d
export AWS_ACCESS_KEY_ID="AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="AWS_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="AWS_DEFAULT_REGION"
docker-compose run sam aws dynamodb create-table \
  --table-name Music \
  --attribute-definitions \
    AttributeName=Artist,AttributeType=S \
    AttributeName=SongTitle,AttributeType=S \
  --key-schema \
    AttributeName=Artist,KeyType=HASH \
    AttributeName=SongTitle,KeyType=RANGE \
  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
  --endpoint-url http://dynamo:8000

docker-compose run sam aws dynamodb put-item \
  --table-name Music  \
  --item \
    '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}, "Year": {"N": "2015"}, "Price": {"N": "2.14"}, "Genre": {"S": "Country"}, "Tags": {"M": {"Composers": {"L": [{"S": "Smith"}, {"S":"Jones"}, {"S":"Davis"}]}, "LenghInSeconds": {"N":"214"}}}}' \
  --return-consumed-capacity TOTAL \
  --endpoint-url http://dynamo:8000

docker-compose run sam aws dynamodb scan \
  --table-name Music \
  --endpoint-url http://dynamo:8000

docker-compose down
docker-compose rm

