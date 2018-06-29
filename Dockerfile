FROM python:3.6

ENV DOCKER_CLIENT_VERSION=18.03.1-ce
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

RUN set eux; \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs \
  && nodejs -v \
  && npm -v \
  && npm install -g js-beautify eslint-cli \
  && js-beautify -v

RUN mkdir /project
WORKDIR /project

RUN set eux; \
  pip install aws-sam-cli awscli \
  && sam --version \
  && aws --version

VOLUME ["/root/.aws"]

# prepare prj,
# sam init --runtime nodejs &&
# cd sam-app/hello_world &&
# npm install && npm test
# ex. sh setup.sh

CMD ["sam", "local", "start-api", "--host", "0.0.0.0"]
