#!/bin/bash

docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd):/project \
  -w /project \
  sum-docker /bin/bash -c "sam init --runtime nodejs \
    && cd sam-app/hello_world \
    && npm install \
    && npm test"

sed -i -r "s#CodeUri:.+#CodeUri: $(pwd)/sam-app/hello_world#g" sam-app/template.yaml
