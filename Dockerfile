FROM python:3.6

ENV DOCKER_CLIENT_VERSION=18.03.1-ce
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs \
  && nodejs -v \
  && npm -v

RUN mkdir /project
WORKDIR /project
COPY . /project

RUN set eux; \
  pip install aws-sam-cli; \
  sam --version

# prepare prj,
# sam init --runtime nodejs &&
# cd sam-app/hello_world &&
# npm install && npm test
# ex. sh setup.sh

CMD ["sam", "local", "start-api", "--host", "0.0.0.0"]
