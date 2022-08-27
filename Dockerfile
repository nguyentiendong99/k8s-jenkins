FROM openjdk:11
EXPOSE 8080
ADD target/k8s-jenkins.jar k8s-jenkins.jar
ENTRYPOINT ["java","-jar","k8s-jenkins.jar"]
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz