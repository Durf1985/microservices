FROM alpine:3.5 AS builder


RUN apk --no-cache add \
    ruby-bundler=1.13.4-r0 \
    ruby-dev=2.3.8-r0 \
    build-base=0.4-r1 \
    ruby-json=2.3.8-r0 \
    ca-certificates=20161130-r1

ENV APP_HOME /app
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME"
ENV BUNDLE_BIN="$GEM_HOME/bin"
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$APP_HOME"

WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/

RUN bundle install
COPY . $APP_HOME

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

FROM alpine:3.5
ENV APP_HOME /app
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME"
ENV BUNDLE_BIN="$GEM_HOME/bin"
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV PATH $BUNDLE_BIN:$PATH
ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

COPY --from=builder $GEM_HOME $GEM_HOME
COPY --from=builder $APP_HOME $APP_HOME
RUN apk --no-cache add \
    ruby=2.3.8-r0 \
    ruby-bundler=1.13.4-r0 \
    ruby-json=2.3.8-r0

WORKDIR $APP_HOME

RUN adduser -D Durf
USER Durf

CMD ["puma"]
LABEL maintainer="Loktionov Aleksey" \
      version="1.0" \
      env="learning"
