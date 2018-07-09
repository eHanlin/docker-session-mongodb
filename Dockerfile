FROM ubuntu:17.10

RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && echo "Asia/Taipei" > /etc/timezone

RUN apt-get update && \
    apt-get install -y dirmngr ca-certificates --install-recommends && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 27017

COPY mongod.conf /etc/mongod.conf

COPY mongo-init.sh /bin/mongo-init.sh

RUN chmod +x /bin/mongo-init.sh

VOLUME /var/lib/mongodb

CMD ["mongod", "-f", "/etc/mongod.conf"]