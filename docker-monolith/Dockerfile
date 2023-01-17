FROM ubuntu:18.04
RUN apt update
RUN apt-get install -y software-properties-common wget sudo git
RUN apt install -y ruby-bundler build-essential
RUN add-apt-repository -y ppa:brightbox/ruby-ng-experimental
RUN apt-get update
RUN apt install -y ruby2.3 ruby2.3-dev
RUN wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org
RUN git clone -b monolith https://github.com/express42/reddit.git
COPY mongod.conf /etc/mongod.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh
RUN cd reddit && bundle install
RUN chmod 0777 /start.sh

CMD ["/start.sh"]
