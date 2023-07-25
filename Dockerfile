FROM jenkins/jenkins:2.6.0

USER root
# ENV CURL_OPTIONS -sSfL --http1.1
# ENV CURL_CONNECTION_TIMEOUT 60
ENV DOCKER_ID=999
ENV ADMIN_ID='admin'
ENV JENKINS_HOME /var/jenkins_home
# ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# ENV CASC_JENKINS_CONFIG /var/jenkins_conf
# COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
# COPY jenkins.yaml /var/jenkins_conf/jenkins.yaml

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/download && \
    curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz | tar -xz -C /tmp/download && \
    rm -rf /tmp/download/docker/dockerd && \
    mv /tmp/download/docker/docker* /usr/local/bin/ && \
    rm -rf /tmp/download && \
    groupadd -g $DOCKER_ID docker && \
    usermod -aG staff,docker jenkins
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-5.0
RUN dotnet --version

RUN dotnet tool install -g dotnet-ef --version 5.0.0
ENV PATH=${PATH}:/root/.dotnet/tools
RUN dotnet ef --version

USER jenkins
