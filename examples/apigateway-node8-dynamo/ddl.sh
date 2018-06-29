#!/bin/bash

aws dynamodb create-table \
  --table-name Music \
  --attribute-definitions \
    AttributeName=Artist,AttributeType=S \
    AttributeName=SongTitle,AttributeType=S \
  --key-schema \
    AttributeName=Artist,KeyType=HASH \
    AttributeName=SongTitle,KeyType=RANGE \
  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
  --endpoint-url http://localhost:8000

aws dynamodb put-item \
  --table-name Music  \
  --item \
    '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}, "Year": {"N": "2015"}, "Price": {"N": "2.14"}, "Genre": {"S": "Country"}, "Tags": {"M": {"Composers": {"L": [{"S": "Smith"}, {"S":"Jones"}, {"S":"Davis"}]}, "LenghInSeconds": {"N":"214"}}}}' \
  --return-consumed-capacity TOTAL \
  --endpoint-url http://localhost:8000

aws dynamodb scan \
  --table-name Music \
  --endpoint-url http://localhost:8000
