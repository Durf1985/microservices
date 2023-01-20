FROM python:3.6.0-alpine
ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts
WORKDIR /app
RUN apk --no-cache --update add build-base=0.4-r1 && \
    pip install --no-cache-dir --requirement /app/requirements.txt && \
    apk del build-base

COPY . /app
ENTRYPOINT ["python3", "post_app.py"]
