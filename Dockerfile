FROM python:3.7-stretch
MAINTAINER Jerry John Stephen (jerryjohnstephen@gmail.com)

# Install node prereqs, nodejs and yarn
# Ref: https://deb.nodesource.com/setup_10.x
# Ref: https://yarnpkg.com/en/docs/install
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -yqq apt-transport-https && \
  echo "deb https://deb.nodesource.com/node_12.x stretch main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -yqq nodejs yarn && \
  npm i -g npm@^6 && \
  pip install --upgrade pip && pip install --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org -r requirements.txt
COPY ./src /usr/src/app
RUN npm install --no-optional && npm cache clean --force
CMD [ "node", "server.js" ]
