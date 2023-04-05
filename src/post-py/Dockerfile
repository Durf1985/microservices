FROM python:3.6.0-alpine
ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts
WORKDIR /app
COPY ./requirements.txt /app
RUN apk --no-cache --update add build-base=0.4-r1 gcc musl-dev && \
    pip install --no-cache-dir --requirement /app/requirements.txt && \
    apk del build-base

COPY . /app
ENTRYPOINT ["python3", "post_app.py"]

LABEL maintainer="Loktionov Aleksey" \
      version="1.0" \
      env="learning"
