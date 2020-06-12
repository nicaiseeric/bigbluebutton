FROM node:8

# Update Debian.
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y debconf-utils debconf apt-utils locales \
 sudo bash wget dpkg-dev git patch g++ build-essential

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
RUN \
sed -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' \
-i /etc/locale.gen && \
locale-gen en_US en_US.UTF-8 && \
locale > /etc/default/locale

#RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
#RUN apt-get install -y nodejs
RUN node -v && nodejs -v

RUN set -x \
 && curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh \
 && useradd -m -G users -s /bin/bash meteor

RUN apt-get update && apt-get -y install jq

COPY . /source

RUN cd /source \
 && mv docker-entrypoint.sh /usr/local/bin/ \
 && chown -R meteor:meteor . \
 && mkdir /app \
 && chown -R meteor:meteor /app

USER meteor

RUN wget https://registry.npmjs.org/amdefine/-/amdefine-1.0.1.tgz -P /source

RUN cd /source \
 && meteor update --allow-superuser --release 1.8 \
 && meteor npm install memwatch-next@0.3.0 \
 && meteor npm install \
 && meteor build --directory /app

ENV NODE_ENV production

RUN cd /app/bundle/programs/server \
 && npm install \
 && npm cache clear --force

WORKDIR /app/bundle

ENV MONGO_URL=mongodb://mongo:27017/html5client \
    PORT=3000 \
    ROOT_URL=http://localhost:3000 \
    METEOR_SETTINGS_MODIFIER=.

EXPOSE 3000

CMD ["docker-entrypoint.sh"]
