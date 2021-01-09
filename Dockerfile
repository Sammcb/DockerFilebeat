FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	gnupg2 \
	wget \
	ca-certificates

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
ENV FB_HOME=/usr/share/filebeat FB_CONF=/etc/filebeat
RUN apt-get update && apt-get install -y --no-install-recommends \
	filebeat

RUN apt-get purge -y gnupg2 wget ca-certificates && apt-get autoremove -y

COPY ./filebeat.yml ${FB_CONF}/filebeat.yml
RUN chmod go-w ${FB_CONF}/filebeat.yml

COPY ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5066

CMD /usr/local/bin/start.sh
