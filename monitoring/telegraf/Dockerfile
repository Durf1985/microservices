FROM telegraf:1.26.0

RUN apt-get update && apt-get install -y --no-install-recommends mtr-tiny=0.94-1+deb11u1 && \
	rm -rf /var/lib/apt/lists/*

COPY telegraf.conf /etc/telegraf/telegraf.conf


