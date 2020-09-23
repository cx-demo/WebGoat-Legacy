FROM openjdk:8-jre-alpine

ARG WEBGOAT_VERSION=6.0.1
ARG IAST_URL=192.168.137.70:8380
ARG IAST_SCANTAG=AWS

RUN apk update && apk add
RUN adduser --system --home /home/webgoat webgoat
RUN cd /home/webgoat/;
RUN chgrp -R 0 /home/webgoat
RUN chmod -R g=u /home/webgoat
RUN apk add ca-certificates libstdc++ glib curl unzip

USER webgoat
WORKDIR /home/webgoat

RUN curl -o cxiast-java-agent.zip http://${IAST_URL}/iast/compilation/download/JAVA && \
    unzip cxiast-java-agent.zip -d /home/webgoat/cxiast-java-agent && \
    rm -rf cxiast-java-agent.zip && \
    chmod +x /home/webgoat/cxiast-java-agent/cx-launcher.jar

COPY target/WebGoat-${WEBGOAT_VERSION}-war-exec.jar /home/webgoat/webgoat.jar

EXPOSE 9000


CMD java -javaagent:/home/webgoat/cxiast-java-agent/cx-launcher.jar -Xverify:none -DcxScanTag=${IAST_SCANTAG} -jar /home/webgoat/webgoat.jar -httpPort 9000