FROM fedora
#FROM docker.pkg.github.com/checkmarx-ts/cxcli-docker/cxcli:2020.4.4

RUN yum install -y zip unzip java-latest-openjdk

RUN adduser -d /home/cxjadx cxjadx


# Get CxCLI from Checkmarx
ADD https://download.checkmarx.com/9.0.0/Plugins/CxConsolePlugin-2021.1.1.zip /tmp/cxcli.zip
RUN unzip /tmp/cxcli.zip -d /opt/cxcli
RUN rm /tmp/cxcli.zip

# Get Jadx
ADD https://github.com/skylot/jadx/releases/download/v1.2.0/jadx-1.2.0.zip /tmp/jadx.zip
RUN unzip /tmp/jadx.zip -d /opt/jadx
RUN rm /tmp/jadx.zip

# Create environment
RUN mkdir apk
VOLUME ["/home/cxjadx/apk"]
RUN chown -R cxjadx:cxjadx /home/cxjadx/apk

ADD run.sh /home/cxjadx/run.sh
RUN chown cxjadx:cxjadx /home/cxjadx/run.sh
RUN chmod a+x /home/cxjadx/run.sh

WORKDIR /home/cxjadx
USER cxjadx

CMD ./run.sh
