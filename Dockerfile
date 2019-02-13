FROM openjdk:8-jdk-alpine3.9
USER root

RUN apk add --update bash && \
    addgroup -g 1000 minecraft && \
    adduser -h /home/minecraft -G minecraft -D -u 1000 minecraft

VOLUME ["/server-data"]

EXPOSE 25565
EXPOSE 33434

ENV EULA true
ENV VERSION "1.10.2"


COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
USER minecraft
WORKDIR /server-data
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
