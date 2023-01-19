FROM ubuntu:18.04
RUN apt-get update -qq \
&& apt-get install -y --no-install-recommends \
ruby-bundler=1.16.1-1 \
ruby-dev=1:2.5.1 \
build-essential=12.4ubuntu1 \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install
COPY . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
