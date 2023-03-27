FROM grafana/grafana:9.4.3

COPY datasource.yml /etc/grafana/provisioning/datasources/datasource.yml

COPY ./dashboards /etc/grafana/provisioning/datasources/dashboards
COPY dashboard.yml /etc/grafana/provisioning/dashboards
