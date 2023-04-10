# syntax=docker/dockerfile:1

FROM openjdk:17-jdk-buster

LABEL version="1.19.2"

RUN apt-get update && apt-get install -y curl dos2unix && \
 addgroup minecraft && \
 adduser --home /data --ingroup minecraft --disabled-password minecraft

COPY launch.sh /launch.sh
RUN dos2unix /launch.sh
RUN chmod +x /launch.sh

COPY --chown=minecraft:minecraft server /server
COPY --chown=minecraft:minecraft server.properties /

RUN dos2unix /server/startserver.sh
RUN chmod +x /server/startserver.sh

USER minecraft

VOLUME /backup
VOLUME /data

WORKDIR /data

EXPOSE 25565/tcp
# RCON
# EXPOSE 25575/tcp

CMD ["/launch.sh"]

ENV EULA "false"

# Start with 4G of ram expandable to 16G
ENV JVM_OPTS "-Xms4g -Xmx16g"
